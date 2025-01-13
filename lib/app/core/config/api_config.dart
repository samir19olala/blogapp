
class ApiConfig {
  // android addr 10.0.2.2
  static const String baseUrl = 
      'http://192.168.1.195.3000/api/v1'; // À remplacer par votre URL d'API

  // Endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String currentUser = '/auth/me';
  static const String posts = '/posts';
  static const String categories = '/categories';
}
