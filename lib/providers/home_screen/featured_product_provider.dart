import 'package:e_commerce/models/product_card.dart';
import 'package:e_commerce/services/feature_product_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // For debugPrint

class FeaturedProductProvider with ChangeNotifier {
  List<ProductCard> _productCards = [];
  bool _isLoading = false;
  String? _errorMessage;

  String? get errorMessage => _errorMessage;
  List<ProductCard> get productCards => _productCards;
  bool get isLoading => _isLoading;

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setErrorMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  Future<void> getAllFeaturedProducts() async {
    _setLoading(true);
    _setErrorMessage(null); // Clear any previous error message
    try {
      // Fetch all products
      List<ProductCard> allProducts = await FeatureProductService.fetchAllFeaturedProducts();

      _productCards = allProducts.take(16).toList();
      _setLoading(false);

      if (_productCards.isEmpty && allProducts.isNotEmpty) {

        _setErrorMessage("No products found after filtering/slicing.");
      } else if (allProducts.isEmpty) {
        _setErrorMessage("No products found from API."); 
      }
    } catch (e) {
      _productCards = []; // Clear products on error
      _setLoading(false);
      _setErrorMessage("Failed to load products: $e"); 
      debugPrint("Error in FeaturedProductProvider: $e"); 
    }
  }
}