import 'package:e_commerce/screens/card_screen.dart';
import 'package:e_commerce/screens/home_screen.dart';
import 'package:e_commerce/screens/listing_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "E-commerce",
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        // Apply a consistent font family
        fontFamily: 'Inter',
      ),
      debugShowCheckedModeBanner: false,
      // Implement tab navigation here
      home: DefaultTabController(
        length: 3, // We will have 3 tabs: Home, Listing, Cart
        child: Scaffold(
          // TabBarView displays the content corresponding to each tab
          body: const TabBarView(
            children: [
              // The order of these children must match the order of tabs below
              HomeScreen(),
              ListingScreen(), // Updated from CategoriesScreen
              CartScreen(),    // Updated from CartScreen (now representing CardScreen)
            ],
          ),
          // TabBar is now in the bottomNavigationBar
          bottomNavigationBar: Container( // Wrap TabBar in a Container for styling
            decoration: BoxDecoration( // Changed to BoxDecoration to add boxShadow
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1), // Shadow color
                  spreadRadius: 1, // How much the box should be spread out
                  blurRadius: 10, // How soft the shadow should be
                  offset: const Offset(0, -3), // Changes position of shadow (x, y)
                ),
              ],
            ),
            child: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home), text: "Home"),
                Tab(
                  icon: Icon(Icons.list_alt),
                  text: "Listing",
                ), // Icon updated for listing
                Tab(icon: Icon(Icons.shopping_cart), text: "Cart"),
              ],
              // Customize TabBar appearance for bottom navigation
              labelColor: Colors.black, // Color for selected tab's label
              unselectedLabelColor: Colors.grey, // Color for unselected tab's label
              indicatorColor: Colors.transparent, // Often transparent for bottom tabs
              // indicatorWeight: 0.0, // Set to 0 if no indicator line is desired
            ),
          ),
        ),
      ),
    );
  }
}
