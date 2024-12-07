import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/news_provider.dart';
import '../providers/bookmark_provider.dart';
import '../widgets/news_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);
    final bookmarkProvider = Provider.of<BookmarkProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search News'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              if (_searchController.text.isNotEmpty) {
                newsProvider.searchArticles(_searchController.text);
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  newsProvider.searchArticles(value);
                }
              },
            ),
          ),
          Expanded(
            child: newsProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : newsProvider.articles.isEmpty
                ? const Center(
              child: Text(
                'No results found.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
                : ListView.builder(
              itemCount: newsProvider.articles.length,
              itemBuilder: (context, index) {
                final article = newsProvider.articles[index];
                final isBookmarked =
                bookmarkProvider.isBookmarked(article);

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
          ),
        ],
      ),
    );
  }
}
