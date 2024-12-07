import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/article.dart';

class ArticleDetailScreen extends StatelessWidget {
  final Article article;

  const ArticleDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.source ?? 'News'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            article.imageUrl != null
                ? Image.network(article.imageUrl!)
                : const SizedBox.shrink(),
            const SizedBox(height: 16),
            Text(
              article.title ?? 'No Title',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(article.description ?? 'No Description'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (article.url != null && await canLaunchUrl(Uri.parse(article.url!))) {
                  await launchUrl(Uri.parse(article.url!));
                }
              },
              child: const Text('Read Full Article'),
            ),
          ],
        ),
      ),
    );
  }
}
