import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/article.dart';
import '../widgets/news_card.dart';
import '../providers/bookmark_provider.dart';

class BookmarksScreen extends StatelessWidget {
  final List<Article>? bookmarks; // Optional: Can be passed manually or fetched from provider

  const BookmarksScreen({super.key, this.bookmarks});

  @override
  Widget build(BuildContext context) {
    final providerBookmarks = Provider.of<BookmarkProvider>(context).bookmarks;

    // Use the provided bookmarks if passed; otherwise, fallback to provider bookmarks
    final displayBookmarks = bookmarks ?? providerBookmarks;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarks'),
      ),
      body: displayBookmarks.isEmpty
          ? const Center(
        child: Text(
          'No bookmarks added yet.',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : ListView.builder(
        itemCount: displayBookmarks.length,
        itemBuilder: (context, index) {
          final article = displayBookmarks[index];
          return NewsCard(
            article: article,
            isBookmarked: true, // Always bookmarked in this screen
            onBookmarkToggled: () {
              Provider.of<BookmarkProvider>(context, listen: false)
                  .removeBookmark(article);
            },
          );
        },
      ),
    );
  }
}
