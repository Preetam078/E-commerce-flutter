import 'package:e_commerce/models/hero_banner.dart';
import 'package:e_commerce/services/hero_banner_service.dart';
import 'package:flutter/material.dart';

class HeroBannerProvider with ChangeNotifier {
  List<HeroBanner> _heroBanners = [];
  bool _isLoading = false;

  //Getters
  List<HeroBanner> get heroBanners => _heroBanners;
  bool get isLoading => _isLoading;

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  //Load hero banners
  Future<void> loadHeroBanners() async {
    _setLoading(true);
    try {
      _heroBanners = await HeroBannerService.getAllHeroBanner();
      _setLoading(false);
    } catch (e) {
      _setLoading(true);
    }
  }
}