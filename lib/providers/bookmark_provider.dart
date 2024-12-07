import 'package:flutter/material.dart';
import '../models/article.dart';

class BookmarkProvider extends ChangeNotifier {
  List<Article> _bookmarks = [];

  List<Article> get bookmarks => _bookmarks;

  // Add article to bookmarks
  void addBookmark(Article article) {
    if (!_bookmarks.contains(article)) {
      _bookmarks.add(article);
      notifyListeners();
    }
  }

  // Remove article from bookmarks
  void removeBookmark(Article article) {
    _bookmarks.remove(article);
    notifyListeners();
  }

  // Check if an article is bookmarked
  bool isBookmarked(Article article) {
    return _bookmarks.contains(article);
  }
}
