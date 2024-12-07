import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/news_provider.dart';
import '../providers/bookmark_provider.dart'; // Import BookmarkProvider
import '../widgets/news_card.dart';
import '../utils/constants.dart';
import 'category_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'general'; // Track selected category

  @override
  void initState() {
    super.initState();
    final newsProvider = Provider.of<NewsProvider>(context, listen: false);
    newsProvider.fetchArticles(selectedCategory); // Fetch articles for the default category
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);
    final bookmarkProvider = Provider.of<BookmarkProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Category Selector
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: newsCategories.length,
              itemBuilder: (context, index) {
                final category = newsCategories[index];
                final isSelected = category == selectedCategory;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = category; // Update selected category
                    });

                    // Fetch articles for the selected category
                    final newsProvider = Provider.of<NewsProvider>(context, listen: false);
                    newsProvider.fetchArticles(category);

                    // Navigate to the CategoryScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryScreen(category: category),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue : Colors.grey, // Highlight selected category
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        category[0].toUpperCase() + category.substring(1),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // News List
          Expanded(
            child: newsProvider.isLoading
                ? const Center(child: CircularProgressIndicator()) // Show loading indicator
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
          ),
        ],
      ),
    );
  }
}
