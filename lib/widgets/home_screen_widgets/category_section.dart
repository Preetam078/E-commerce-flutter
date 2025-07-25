import 'package:e_commerce/providers/home_screen/category_provider.dart';
import 'package:e_commerce/widgets/sharable_widgets/tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategorySection extends StatefulWidget {
  const CategorySection({super.key});

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CategoryProvider>(context, listen: false).getAllCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, categoryProvider, child) {
        const double placeholderHeight = 100.0; // Consistent height for placeholders

        if (categoryProvider.isLoading) {
          return const SizedBox(
            height: placeholderHeight,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (categoryProvider.errorMessage != null) {
          return SizedBox(
            height: placeholderHeight,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Error: ${categoryProvider.errorMessage}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ),
          );
        } else if (categoryProvider.categories.isEmpty) {
          return const SizedBox(
            height: placeholderHeight,
            child: Center(
              child: Text("No categories found."),
            ),
          );
        }

        // Categories are loaded, display them using Wrap
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10), // Increased spacing for better visual separation

                // Using Wrap instead of ListView for wrapping tabs
                Wrap(
                  spacing: -3.0, // Horizontal space between tabs
                  runSpacing: -3.0, // Vertical space between lines of tabs
                  children: categoryProvider.categories.map((categoryName) {
                    return TabWidget(
                      tabCta: categoryName,
                      tabClick: () {
                        print('Tapped on category: $categoryName');
                        // Add your actual category selection logic here
                      },
                    );
                  }).toList(), // Convert the iterable to a List
                ),
                const SizedBox(height: 16), // Add some space after the tabs
              ],
            ),
          ),
        );
      },
    );
  }
}