import 'package:e_commerce/utils/category_data.dart';

class CategoryService {  
  static Future<List<String>> fetchAllCategories() async {
    try {
      Future.delayed(const Duration(seconds: 1));
      final allCategories = CategoryData.allCategories();
      return allCategories;
    } catch (e) {
      throw Exception("Network Error $e");
    }
  }

}