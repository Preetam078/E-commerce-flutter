import 'package:e_commerce/models/hero_banner.dart';
import 'package:e_commerce/utils/hero_banner_data.dart';

class HeroBannerService {
  static Future<List<HeroBanner>> getAllHeroBanner() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return HeroBannerData.heroBanners();
    } catch (e) {
      throw Exception("Network error $e");
    }
  }
}