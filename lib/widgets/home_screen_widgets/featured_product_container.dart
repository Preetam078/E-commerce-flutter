import 'package:e_commerce/providers/home_screen/featured_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeaturedProductContainer extends StatefulWidget {
  const FeaturedProductContainer({super.key});

  @override
  State<FeaturedProductContainer> createState() => _FeaturedProductContainerState();
}

class _FeaturedProductContainerState extends State<FeaturedProductContainer> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FeaturedProductProvider>(context, listen: false).getAllFeaturedProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FeaturedProductProvider>(
      builder: (context, featuredProductProvider, child) {
        const double placeholderHeight = 200.0;

        if (featuredProductProvider.isLoading) {
          return const SizedBox(
            height: placeholderHeight,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (featuredProductProvider.errorMessage != null) {
          return SizedBox(
            height: placeholderHeight,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  featuredProductProvider.errorMessage!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ),
          );
        } else if (featuredProductProvider.productCards.isEmpty) {
          return const SizedBox(
            height: placeholderHeight,
            child: Center(
              child: Text("No featured products available."),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Featured Products",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 0.75, // Adjust as needed
                ),
                itemCount: featuredProductProvider.productCards.length,
                itemBuilder: (context, index) {
                  final product = featuredProductProvider.productCards[index];
                  return Card(
                    elevation: 0.4,
                    clipBehavior: Clip.antiAlias,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child:
                              Image.network(
                            product.thumbnail,
                            fit: BoxFit.cover, 
                            width: double.infinity,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[300],
                                alignment: Alignment.center,
                                child: Icon(Icons.broken_image, color: Colors.grey[600]),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text('\$${product.price.toStringAsFixed(2)}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}