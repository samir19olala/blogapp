import 'dart:async';
import 'dart:convert';

import 'package:blogapp/app/data/services/mock_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../core/config/api_config.dart';
import '../models/post_model.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  ApiException({
    required this.message,
    this.statusCode,
    this.data,
  });

  @override
  String toString() => 'ApiException: $message';
}

class ApiService extends GetxService {
  static const String baseUrl = ApiConfig.baseUrl;
  final String _storageKey = 'auth_token';
  late final GetStorage _storage;

  String? _accessToken;
  String? _refreshToken;
  DateTime? _tokenExpiration;
  Timer? _refreshTimer;

  // Getters
  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;
  bool get isAuthenticated => _accessToken != null;

  // Headers
  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        if (_accessToken != null) 'Authorization': 'Bearer $_accessToken',
      };

  // Initialisation du service
  Future<ApiService> init() async {
    _storage = GetStorage();
    _loadAuthToken();
    _setupTokenRefresh();
    return this;
  }

  void _setupTokenRefresh() {
    if (_tokenExpiration != null) {
      // Annuler le timer existant s'il y en a un
      _refreshTimer?.cancel();

      // Calculer le délai avant expiration (5 minutes avant)
      final now = DateTime.now();
      final timeUntilRefresh = _tokenExpiration!
          .subtract(const Duration(minutes: 5))
          .difference(now);

      if (timeUntilRefresh.isNegative) {
        // Si le token est déjà expiré ou proche de l'expiration, rafraîchir immédiatement
        refreshTokens();
      } else {
        // Programmer le rafraîchissement
        _refreshTimer = Timer(timeUntilRefresh, refreshTokens);
      }
    }
  }

  Future<void> refreshTokens() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/${ApiConfig.refreshToken}'),
        headers: _headers,
        body:json.encode({
         'refresh_token': _refreshToken,
        })
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _accessToken = data['data']['accessToken'];
        _refreshToken = data['data']['refreshToken'];
        _tokenExpiration = DateTime.now().add(const Duration(hours: 1));

        // Sauvegarder le nouveau token
        await _storage.write(_storageKey, {
          'access_token': _accessToken,
          'expiration': _tokenExpiration!.toIso8601String(),
          'refree_token': _refreshToken,
        });

        // Configurer le prochain rafraîchissement
        _setupTokenRefresh();
      } else {
        // En cas d'échec, déconnecter l'utilisateur
        logout();
      }
    } catch (e) {
      debugPrint('Erreur lors du rafraîchissement du token: $e');
      logout();
    }
  }

  void _loadAuthToken() {
    final authData = _storage.read(_storageKey);

    if (authData != null) {
      _accessToken = authData['access_token'];
      _tokenExpiration = DateTime.tryParse(authData['expiration'] ?? '');
      _refreshToken = authData['refresh_token'];
      _setupTokenRefresh();
    }
  }

  Future<void> _saveAuthToken({required  accessToken,required String reflreshToken}) async {
    try {
      _accessToken = accessToken;
      
      _tokenExpiration = DateTime.now().add(const Duration(hours: 1));
      await _storage.write(_storageKey, {
        'access_token': accessToken,
        'expiration': _tokenExpiration!.toIso8601String(),
        'refresh_token': reflreshToken,
      });
      _setupTokenRefresh();
    } catch (e) {
      throw ApiException(message: 'Erreur lors de la sauvegarde du token: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    // Récupérer le token stocké si existant
    _loadAuthToken();
  }

  // Méthode générique pour les requêtes HTTP
  Future<T> _handleRequest<T>({
    required Future<http.Response> Function() requestFunction,
    required T Function(dynamic data) onSuccess,
    String errorMessage = 'Erreur de requête',
  }) async {
    try {
      final response = await requestFunction();
      final data = json.decode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return onSuccess(data);
      } else {
        throw ApiException(
          message: data['message'] ?? errorMessage,
          statusCode: response.statusCode,
          data: data,
        );
      }
    } on http.ClientException catch (e) {
      throw ApiException(
        message: 'Erreur de connexion: ${e.message}',
      );
    } on FormatException {
      throw ApiException(
        message: 'Erreur de format de réponse',
      );
    } catch (e) {
      throw ApiException(
        message: 'Erreur inattendue: $e',
      );
    }
  }

  // Méthodes CRUD génériques
  Future<T> get<T>(String endpoint, T Function(dynamic) fromJson) async {
    return _handleRequest(
      requestFunction: () => http.get(
        Uri.parse('$baseUrl/$endpoint'),
        headers: _headers,
      ),
      onSuccess: (data) => fromJson(data),
    );
  }

  Future<T> post<T>(
    String endpoint,
    dynamic body,
    T Function(dynamic) fromJson,
  ) async {
    return _handleRequest(
      requestFunction: () => http.post(
        Uri.parse('$baseUrl/$endpoint'),
        headers: _headers,
        body: json.encode(body),
      ),
      onSuccess: (data) => fromJson(data),
    );
  }

  Future<T> put<T>(
    String endpoint,
    dynamic body,
    T Function(dynamic) fromJson,
  ) async {
    return _handleRequest(
      requestFunction: () => http.put(
        Uri.parse('$baseUrl/$endpoint'),
        headers: _headers,
        body: json.encode(body),
      ),
      onSuccess: (data) => fromJson(data),
    );
  }

  Future<void> delete(String endpoint) async {
    return _handleRequest(
      requestFunction: () => http.delete(
        Uri.parse('$baseUrl/$endpoint'),
        headers: _headers,
      ),
      onSuccess: (_) {},
    );
  }

  // Méthodes d'authentification
  Future<void> login(String email, String password) async {
    final response = await post<Map<String, dynamic>>(
      ApiConfig.login,
      {'email': email, 'password': password},
      (data) => data as Map<String, dynamic>,
    );

    if (response['data']['accessToken'] != null) {
      final accessToken = response['data']['accessToken'];
      final refreshToken = response['data']['refreshToken'];
      await _saveAuthToken(accessToken:accessToken,reflreshToken:refreshToken);
    } else {
      throw ApiException(message: 'Token non trouvé dans la réponse');
    }
  }

  Future<void> logout() async {
    _accessToken = null;
    _refreshToken = null;
    _tokenExpiration = null;
    _refreshTimer?.cancel();
    await _storage.remove(_storageKey);
  }

  // Exemple de méthode spécifique pour les stories
  Future<List<Post>> getPosts() async {
    final List<Post> data = MockService.getMockPosts();
    return data;
    // return _handleRequest(
    //   requestFunction: () => http.get(
    //     Uri.parse('$baseUrl/stories'),
    //     headers: _headers,
    //   ),
    //   onSuccess: (data) =>
    //       (data as List).map((json) => Post.fromJson(json)).toList(),
    //   errorMessage: 'Impossible de charger les stories',
    // );
  }
  // Exemple de méthode spécifique pour les stories
  Future<List<String>> getCategories() async {
    final List<String> data = MockService.getMockCategories();
    return data;
    // return _handleRequest(
    //   requestFunction: () => http.get(
    //     Uri.parse('$baseUrl/stories'),
    //     headers: _headers,
    //   ),
    //   onSuccess: (data) =>
    //       (data as List).map((json) => Post.fromJson(json)).toList(),
    //   errorMessage: 'Impossible de charger les stories',
    // );
  }

  
}
