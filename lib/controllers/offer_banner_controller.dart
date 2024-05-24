import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class OfferBannerController extends GetxController {
  RxList<String> offerBanner = RxList<String>([]);

  @override
  void onInit() {
    super.onInit();
    fetchOfferBannerUrls();
  }

  Future<void> fetchOfferBannerUrls() async {
    try {
      QuerySnapshot offerBannerUrls =
          await FirebaseFirestore.instance.collection("124507_offers").get();
      if (offerBannerUrls.docs.isNotEmpty) {
        offerBanner.value =
            offerBannerUrls.docs.map((doc) => doc['ImgUrl'] as String).toList();
      }
    } catch (e) {
      // ignore: avoid_print
      print("Error: $e");
    }
  }
}
