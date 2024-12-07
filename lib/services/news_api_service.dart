import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article.dart';

class NewsApiService {
  static const String _apiKey = 'e0034994e94b4df3b83ced63be55da83';
  static const String _baseUrl = 'https://newsapi.org/v2';

  /// Fetches top headlines for a specific category.
  Future<List<Article>> fetchTopHeadlines(String category) async {
    final url = Uri.parse('$_baseUrl/top-headlines?country=us&category=$category&apiKey=$_apiKey');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'ok') {
          final List articles = data['articles'];
          return articles.map((article) => Article.fromJson(article)).toList();
        }
      }
      throw Exception('Failed to load top headlines');
    } catch (error) {
      rethrow;
    }
  }

  /// Searches for articles based on a query string.
  Future<List<Article>> searchArticles(String query) async {
    final url = Uri.parse('$_baseUrl/everything?q=$query&apiKey=$_apiKey');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'ok') {
          final List articles = data['articles'];
          return articles.map((article) => Article.fromJson(article)).toList();
        }
      }
      throw Exception('Failed to load search results');
    } catch (error) {
      rethrow;
    }
  }
}
