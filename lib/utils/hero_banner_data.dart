import 'package:e_commerce/models/hero_banner.dart';

class HeroBannerData {
  static List<HeroBanner> heroBanners() {
    return [
      HeroBanner.forHomeDecor(
        id: 123,
        bannerImageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuDxYyt-24vJASkDTDFyH1qA0ajP0aGWdgZEo-ClWf44q1t3fEKLZcV_ybVmtwX7dFdZ7LCyUsmqRWDdQ_6F8nfk3FDWU_Ta2aScA2HqA4c7WqGJbeWQ-IdeJHfKJNfyLO9Ct_LXK7fZdlPASCySwiNh0dTWis88UffPJ7SVFv1Xs5M_-SFBnwyfvcSxoFbQrCRh9NabiuS35fCPkeMiAf0zmU-lOU7bMpgfzCGi4trugdIE57MjYVoyxSPggnBQy-Q-SEUIdOPv08o",
      ),
      HeroBanner.forKitchenware(
        id: 345,
        bannerImageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuAcCuhk7BeVqqH4JJK8ntshuontoUZ5VXW1TcG_wDbcWJ2oavSZicfXiDAe66ukZh8XxiTJ5Be-5Gr8DbuFAr1_ss9dHQ8SCQi_FW3Iz8ed12VVVbg8e6Deg7bZsX3YEDghUivki9S7MjnILgmC_It3rcmQTJ1EPE32KvfSZrBWQOhjaKGjPnsTYj9hZych9Y968V7MbxHqmay6yPKAW8muAHVtVuTJN3GNwbJYK7S4cuft2b34htIrc9ijONUXxFXVOC46hzb_oNA",
      ),
    ];
  }
}