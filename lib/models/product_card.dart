// lib/models/product_card.dart (or wherever your ProductCard is defined)

class ProductCard {
  final int id;
  final String title;
  final double price;
  final String thumbnail;

  ProductCard({
    required this.id,
    required this.title,
    required this.price,
    required this.thumbnail
  });

  factory ProductCard.fromJson(Map<String, dynamic> jsonResponse) {
    return ProductCard(
      id: jsonResponse['id'] ?? 0,
      title: jsonResponse['title'] ?? "",
      // <--- IMPORTANT: Ensure safe parsing for price.
      // Use ?.toDouble() if it might be an int or double from JSON.
      // If the API always sends it as a number, (jsonResponse['price'] as num).toDouble() is safest.
      price: (jsonResponse['price'] as num?)?.toDouble() ?? 0.0,
      thumbnail: jsonResponse['thumbnail'] ?? ""
    );
  }
}