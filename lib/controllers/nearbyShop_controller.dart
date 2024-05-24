import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/branded_shop_model.dart';
import '../models/outlet_model.dart';

import 'package:takeit/services/mongo_db.dart';

class ShopController extends GetxController {
  final dbService = Get.find<DatabaseService>();
// Now you can use `dbService` to access your database methods

  // final _firestore = FirebaseFirestore.instance;

  // Observable list of branded shops
  RxList<BrandedShop> brandedShops = <BrandedShop>[].obs;

  // Observable list of outlets for the currently selected brand
  RxList<Outlet> outlets = <Outlet>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() async {
    super.onInit();
    DatabaseService().connect().then((value) => fetchBrandedShops());
    fetchBrandedShops();
  }

  // Fetches all branded shops from Firestore
  Future<void> fetchBrandedShops() async {
    try {
      final db = dbService.db;
      final result = await db.collection('brandedShops').find().toList();

      // ignore: avoid_print
      print('Number of branded shops fetched: ${result.length}');

      brandedShops.value =
          result.map((data) => BrandedShop.fromMap(data)).toList();
    } catch (e) {
      print('Error fetching branded shops: $e');
    } finally {
      isLoading.value = false; // Update loading state after fetching
    }
  }

  // Fetches outlets for a specific branded shop
  Future<void> fetchOutletsForBrand(String brandedShopId) async {
    try {
      final db = dbService.db; // Get the database instance
      final result = await db
          .collection('outlets')
          .find({'brandedShopId': brandedShopId}).toList();

      outlets.value = result.map((data) => Outlet.fromMap(data)).toList();
    } catch (e) {
      // Handle errors (e.g., show error message)
      print('Error fetching outlets: $e');
    } finally {
      isLoading.value = false; // Done loading (even on error)
    }
  }
}
