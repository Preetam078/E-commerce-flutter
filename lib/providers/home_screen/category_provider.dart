import 'package:e_commerce/services/category_service.dart';
import 'package:flutter/foundation.dart'; // For debugPrint
import 'package:flutter/material.dart'; // No longer strictly needed for ChangeNotifier

class CategoryProvider with ChangeNotifier {
  List<String> _categories = [];
  bool _isLoading = false;
  String? _errorMessage; // Added for error communication

  // Removed the BuildContext parameter from the constructor.
  // The default no-argument constructor is fine.
  // CategoryProvider(BuildContext context); // REMOVED THIS LINE

  //Getter
  List<String> get categories => _categories;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage; // Getter for error message

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setErrorMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  Future<void> getAllCategories() async {
    _setLoading(true);
    _setErrorMessage(null); // Clear previous errors
    try {
      final allCategories = await CategoryService.fetchAllCategories();
      _categories = allCategories;
      _setLoading(false); // Set to false on success
    } catch (e) {
      _categories = []; // Clear categories on error
      _setLoading(false); // Set to false even on error
      _setErrorMessage(e.toString()); // Set the error message
      debugPrint('Error fetching categories: $e'); // Log error for debugging
    }
  }
}