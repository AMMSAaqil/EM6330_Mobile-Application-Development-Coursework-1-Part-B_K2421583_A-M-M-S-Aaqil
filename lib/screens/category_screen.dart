import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/news_provider.dart';
import '../providers/bookmark_provider.dart';
import '../widgets/news_card.dart';

class CategoryScreen extends StatelessWidget {
  final String category;

  const CategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);
    final bookmarkProvider = Provider.of<BookmarkProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('${category.toUpperCase()} News'),
      ),
      body: newsProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : newsProvider.articles.isEmpty
          ? const Center(
        child: Text(
          'No articles found for this category.',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : ListView.builder(
        itemCount: newsProvider.articles.length,
        itemBuilder: (context, index) {
          final article = newsProvider.articles[index];
          final isBookmarked = bookmarkProvider.isBookmarked(article);

          return NewsCard(
            article: article,
            isBookmarked: isBookmarked,
            onBookmarkToggled: () {
              if (isBookmarked) {
                bookmarkProvider.removeBookmark(article);
              } else {
                bookmarkProvider.addBookmark(article);
              }
            },
          );
        },
      ),
    );
  }
}
