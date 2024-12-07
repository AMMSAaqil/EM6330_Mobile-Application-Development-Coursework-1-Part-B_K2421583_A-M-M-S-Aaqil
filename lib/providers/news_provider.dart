import 'package:flutter/material.dart';
import '../models/article.dart';
import '../services/news_api_service.dart';

class NewsProvider with ChangeNotifier {
  final NewsApiService _newsApiService = NewsApiService();

  List<Article> _articles = [];
  List<Article> get articles => _articles;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchArticles(String category) async {
    _isLoading = true;
    notifyListeners();

    try {
      _articles = await _newsApiService.fetchTopHeadlines(category);
    } catch (error) {
      _articles = [];
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchArticles(String query) async {
    _isLoading = true;
    notifyListeners();

    try {
      _articles = await _newsApiService.searchArticles(query);
    } catch (error) {
      _articles = [];
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
