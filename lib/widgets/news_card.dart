import 'package:flutter/material.dart';
import '../models/article.dart';
import '../screens/article_detail_screen.dart';

class NewsCard extends StatelessWidget {
  final Article article;
  final bool isBookmarked; // Add this
  final VoidCallback onBookmarkToggled; // Add this

  const NewsCard({
    super.key,
    required this.article,
    required this.isBookmarked,
    required this.onBookmarkToggled,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleDetailScreen(article: article),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.imageUrl != null)
              Image.network(
                article.imageUrl!,
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.broken_image, size: 100),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title ?? 'No Title',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    article.description ?? 'No Description',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // Bookmark Button
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(
                  isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: isBookmarked ? Colors.blue : null,
                ),
                onPressed: onBookmarkToggled,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
