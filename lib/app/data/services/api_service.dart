import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../models/Post_model.dart';
import 'mock_service.dart';

class ApiService extends GetxService {
  static const String baseUrl = 'YOUR_API_BASE_URL';

  Future<List<Post>> getPosts() async {
    try {
      // TODO: Replace with actual API call
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 800));
      // final response = await http.get(Uri.parse('$baseUrl/stories'));
      // if (response.statusCode == 200) {
      //   final List<dynamic> data = json.decode(response.body);
      //   return data.map((json) => Post.fromJson(json)).toList();
      // } else {
      //   throw Exception('Failed to load stories');
      // }
      return MockService.getMockPosts();
    } catch (e) {
      throw Exception('Failed to load stories: $e');
    }
  }

  Future<List<String>> getCategories() async {
    try {
      // TODO: Replace with actual API call
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));
      // final response = await http.get(Uri.parse('$baseUrl/categories'));
      // if (response.statusCode == 200) {
      //   final List<dynamic> data = json.decode(response.body);
      //   return data.map((category) => category.toString()).toList();
      // } else {
      //   throw Exception('Failed to load categories');
      // }
      return MockService.getMockCategories();
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }

  Future<Post> getPostDetails(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/stories/$id'));

      if (response.statusCode == 200) {
        return Post.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load Post details');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }

  Future<void> createPost(Map<String, dynamic> PostData) async {
    try {
      // TODO: Replace with actual API call
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      // final response = await http.post(
      //   Uri.parse('$baseUrl/stories'),
      //   headers: {'Content-Type': 'application/json'},
      //   body: json.encode(PostData),
      // );
      // if (response.statusCode == 201) {
      //   return Post.fromJson(json.decode(response.body));
      // } else {
      //   throw Exception('Failed to create Post');
      // }
      // For now, just print the data that would be sent
      print('Creating Post with data: $PostData');
    } catch (e) {
      throw Exception('Failed to create Post: $e');
    }
  }

  Future<void> updatePost(int id, Map<String, dynamic> PostData) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/stories/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(PostData),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update Post');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }

  Future<void> deletePost(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/stories/$id'));

      if (response.statusCode != 204) {
        throw Exception('Failed to delete Post');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }
}
