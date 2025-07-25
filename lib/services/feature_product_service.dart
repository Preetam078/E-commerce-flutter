import 'dart:convert';

import 'package:e_commerce/models/product_card.dart'; // Make sure this path is correct
import 'package:e_commerce/utils/api_constant.dart'; // Make sure this path is correct
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart'; // For debugPrint

class FeatureProductService {
  static Future<List<ProductCard>> fetchAllFeaturedProducts() async {
    String baseUrl = ApiConstant.baseUrl();
    debugPrint('Attempting to fetch products from: $baseUrl'); // Debug log

    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
      );

      debugPrint('Response Status Code: ${response.statusCode}');
      debugPrint('Response Body (first 200 chars): ${response.body.substring(0, response.body.length > 200 ? 200 : response.body.length)}'); // Log part of response

      if (response.statusCode == 200) {
        final dynamic decodedJson = json.decode(response.body); // Decode as dynamic first

        List<dynamic> productListJson;

        // --- IMPORTANT: Adjust this logic based on your API's actual response structure ---
        if (decodedJson is List) {
          // Case 1: The API directly returns a JSON array (less likely given your error)
          productListJson = decodedJson;
        } else if (decodedJson is Map<String, dynamic>) {
          // Case 2: The API returns a JSON object, and the list is under a key
          if (decodedJson.containsKey('products')) { // Common key (e.g., dummyjson.com)
            productListJson = decodedJson['products'] as List<dynamic>;
          } else if (decodedJson.containsKey('data')) { // Another common key
            productListJson = decodedJson['data'] as List<dynamic>;
          } else {
            // Case 3: It's a map, but the expected list key is missing
            // This might also happen if the API returns a single product object
            // when expecting a list, or an unexpected structure.
            throw Exception('Unexpected JSON format: Top-level is a Map but does not contain "products" or "data" key with a list.');
          }
        } else {
          // Fallback for any other unexpected top-level type
          throw Exception('Unexpected JSON format: Top-level element is neither a List nor a Map. Received: ${decodedJson.runtimeType}');
        }

        // Now, map the extracted list of product JSONs to ProductCard objects
        return productListJson.map((jsonItem) => ProductCard.fromJson(jsonItem as Map<String, dynamic>)).toList();
      } else {
        throw Exception('Failed to load featured products: Status code ${response.statusCode}, Response Body: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error in FeatureProductService (caught): $e');
      throw Exception("Network error or failed to parse data: $e");
    }
  }
}

// Your ProductCard model and FeaturedProductProvider should remain as they are,
// assuming the ProductCard.fromJson correctly maps 'id', 'title', and 'price'.
// If 'price' is a double in your API, ensure ProductCard stores it as double
// and adjust the fromJson mapping accordingly (e.g., jsonResponse['price']?.toDouble() ?? 0.0).

/*
// Example of ProductCard if price is double
class ProductCard {
  final int id;
  final String title;
  final double price; // Changed to double

  ProductCard({
    required this.id,
    required this.title,
    required this.price
  });

  factory ProductCard.fromJson(Map<String, dynamic> jsonResponse) {
    return ProductCard(
      id: jsonResponse['id'] ?? 0,
      title: jsonResponse['title'] ?? "",
      // Ensure price handles both int and double if API is inconsistent
      price: (jsonResponse['price'] is num) ? jsonResponse['price'].toDouble() : 0.0,
    );
  }
}
*/