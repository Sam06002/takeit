import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/branded_shop_model.dart';

class BrandedShopController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Observable list of branded shops
  final RxList<BrandedShop> _brandedShops = <BrandedShop>[].obs;
  List<BrandedShop> get brandedShops => _brandedShops;

  // Loading state
  var _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  //Fetch all Branded Shops
  Future<void> getBrandedShops() async {
    try {
      final snapshot = await _firestore.collection('brandedShops').get();
      _brandedShops.value = snapshot.docs
          .map((doc) => BrandedShop.fromDocumentSnapshot(doc))
          .toList();
      //print("Fetched shops: ${_brandedShops.value}");
    } catch (e) {
      // Handle error here
      //print('Error fetching branded shops: $e');
    } finally {
      _isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getBrandedShops();
  }
}
