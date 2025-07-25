import 'package:e_commerce/providers/home_screen/hero_banner_provider.dart';
import 'package:e_commerce/widgets/home_screen_widgets/hero_banner_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui' show lerpDouble;

class HeroBannerContainer extends StatefulWidget {
  const HeroBannerContainer({super.key});

  @override
  State<HeroBannerContainer> createState() => _HeroBannerContainerState();
}

class _HeroBannerContainerState extends State<HeroBannerContainer> {
  final PageController _pageController = PageController(viewportFraction: 0.9);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HeroBannerProvider>(context, listen: false).loadHeroBanners();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HeroBannerProvider>(
      builder: (context, heroBannerProvider, child) {
        if (heroBannerProvider.isLoading) {
          // Keep Center for loading/error/empty states for better UX
          return const SizedBox(
            height: 228,
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (heroBannerProvider.heroBanners.isEmpty) {
          return const SizedBox(
            height: 200,
            child: Center(child: Text("No banners available.")),
          );
        }

        return Column(
          children: [
            SizedBox(
              height: 200,
              child: PageView.builder(
                controller: _pageController,
                itemCount: heroBannerProvider.heroBanners.length,
                itemBuilder: (context, index) {
                  final banner = heroBannerProvider.heroBanners[index];
                  return AnimatedBuilder(
                    animation: _pageController,
                    builder: (context, child) {
                      double value = 1.0;
                      // Ensure position has dimensions before accessing page
                      if (_pageController.position.haveDimensions) {
                        value = _pageController.page! - index;
                        // Clamped to control the extent of the animation
                        value = (1 - (value.abs() * 0.4)).clamp(0.0, 1.0);
                      }
                      // Removed Center here. The SizedBox will now directly constrain the child.
                      return SizedBox(
                        height: Curves.easeOut.transform(value) * 200,
                        width: Curves.easeOut.transform(value) *
                            MediaQuery.of(context).size.width,
                        child: child,
                      );
                    },
                    child: HeroBannerCard(heroBanner: banner),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            AnimatedBuilder(
              animation: _pageController,
              builder: (context, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    heroBannerProvider.heroBanners.length,
                    (index) {
                      double distance = (_pageController.hasClients &&
                              _pageController.page != null)
                          ? (_pageController.page! - index).abs()
                          : 1.0;
                      double normalizedDistance = (distance * 2).clamp(0.0, 1.0);
                      Color dotColor = Color.lerp(
                        Colors.grey[900], // Active color
                        Colors.grey, // Inactive color
                        normalizedDistance,
                      )!;

                      double dotWidth = lerpDouble(
                        24.0, // Active width
                        8.0, // Inactive width
                        normalizedDistance,
                      )!;

                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        height: 8.0,
                        width: dotWidth,
                        decoration: BoxDecoration(
                          color: dotColor,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
          ],
        );
      },
    );
  }
}