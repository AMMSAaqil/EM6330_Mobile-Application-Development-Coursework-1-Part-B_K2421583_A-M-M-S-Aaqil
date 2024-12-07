import 'package:flutter/material.dart';

class CategorySelector extends StatelessWidget {
  final List<String> categories;
  final Function(String) onSelected;

  const CategorySelector({super.key, required this.categories, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onSelected(categories[index]),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  categories[index],
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
