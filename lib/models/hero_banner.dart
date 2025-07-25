class HeroBanner {

  final int id;
  final String bannerImageUrl;
  final String title;
  final String description;

  HeroBanner({
    required this.id,
    required this.bannerImageUrl,
    required this.title,
    required this.description
  });

  // Example named constructor
  HeroBanner.forHomeDecor({
    required this.id,
    required this.bannerImageUrl,
    this.title = "Elevate Your Living Space",
    this.description = "Discover our curated collection of furniture and decor.",
  });

  HeroBanner.forKitchenware({
    required this.id,
    required this.bannerImageUrl,
    this.title = "Cook with Style",
    this.description = "Upgrade your kitchen with our latest appliances and gadgets.",
  });
}