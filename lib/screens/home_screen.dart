import 'package:e_commerce/providers/home_screen/category_provider.dart';
import 'package:e_commerce/providers/home_screen/featured_product_provider.dart';
import 'package:e_commerce/providers/home_screen/hero_banner_provider.dart';
import 'package:e_commerce/widgets/home_screen_widgets/category_section.dart';
import 'package:e_commerce/widgets/home_screen_widgets/featured_product_container.dart';
import 'package:e_commerce/widgets/home_screen_widgets/hero_banner_container.dart';
import 'package:e_commerce/widgets/sharable_widgets/app_bar_widget.dart';
import 'package:e_commerce/widgets/sharable_widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarWidget(
        appBarHeader: "Shop",
        suffixIconData: Icons.shopping_bag_outlined,
        onSuffixIconClick: _onSearchIconClick,
      ),
      body: SingleChildScrollView( // <--- Re-added SingleChildScrollView here
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SearchBarWidget(),
            // Use MultiProvider to provide all necessary providers
            MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (context) => HeroBannerProvider()),
                ChangeNotifierProvider(create: (context) => CategoryProvider()),
                ChangeNotifierProvider(create: (context) => FeaturedProductProvider()),
              ],
              child: const Column( // This Column holds the main content sections
                crossAxisAlignment: CrossAxisAlignment.start, // Ensure children align to start
                children: [
                  HeroBannerContainer(),
                  SizedBox(height: 20), // Spacing between sections
                  CategorySection(),
                  SizedBox(height: 20), // Spacing between sections
                  FeaturedProductContainer(),
                  SizedBox(height: 20), // Spacing at the bottom for better scroll experience
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void _onSearchIconClick() {
    print('Search icon clicked from HomeScreen!');
    // Implement logic like navigating to a search screen
  }
}