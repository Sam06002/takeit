import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:get/get.dart';
import 'package:location/location.dart' as loc;

import '../models/products_model.dart';
import '../models/shop_model.dart';

class ShopDetailController extends GetxController {
  TextEditingController searchController = TextEditingController();
  RxList<Product> filteredProducts = <Product>[].obs;

  String shopId = "";

  ShopDetailController({required this.shopId});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final Rx<Shop?> _shop = Rx<Shop?>(null);
  Shop? get shop => _shop.value;

  RxList<Product> products = <Product>[].obs; // Use RxList

  @override
  void onInit() {
    super.onInit();
    fetchShopDetails();
    fetchProducts(); // Fetch products as well
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  Future<List<Shop>> fetchShopsWithinRadius(
      loc.LocationData userLocation, double radiusInKm) async {
    final _firestore = FirebaseFirestore.instance;
    GeoFlutterFire geo = GeoFlutterFire();

    GeoFirePoint center = geo.point(
        latitude: userLocation.latitude!, longitude: userLocation.longitude!);

    var collectionReference = _firestore.collection('shops');

    Stream<List<DocumentSnapshot>> stream = geo
        .collection(collectionRef: collectionReference)
        .within(center: center, radius: radiusInKm, field: 'location');

    List<Shop> shops = [];

    await stream.first.then((value) {
      value.forEach((element) {
        shops.add(
          Shop(
            geohash: "", isOpen: true, rating: 5, category: "", image: "",

            shopId: element.id,
            name: element['name'],
            address: element['address'],
            latitude: element['location']['geopoint'].latitude,
            longitude: element['location']['geopoint'].longitude,
            // ... other fields from your Shop model
          ),
        );
      });
    });

    return shops;
  }

  Future<void> fetchShopDetails() async {
    this.shopId = shopId;
    try {
      final snapshot = await _firestore.collection('shops').doc(shopId).get();
      if (snapshot.exists) {
        _shop.value = Shop.fromMap(snapshot.data()!);
        if (_shop.value != null && _shop.value!.rating is int) {
          // Check if rating is int
          _shop.value = _shop.value!.copyWith(
            rating:
                (_shop.value!.rating as int).toDouble(), // Convert to double
          );
        }
      } else {
        // Handle case where the shop document doesn't exist
      }
    } catch (e) {
      // Handle errors (e.g., network issues, incorrect shopId)
      print("Error fetching shop details: $e");
    }
  }

  Future<void> fetchProducts() async {
    try {
      final productsSnapshot = await FirebaseFirestore.instance
          .collection('shops/$shopId/shopProducts') // Updated path
          .get();

      final productReferences =
          productsSnapshot.docs.map((doc) => doc.get('productId')).toList();

      if (productReferences.isNotEmpty) {
        final fetchedProducts = await FirebaseFirestore.instance
            .collection('products')
            .where(FieldPath.documentId, whereIn: productReferences)
            .get();

        products.value = fetchedProducts.docs
            .map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>))
            .toList();
      } else {
        products.value = [];
      }
    } catch (e) {
      print("Error fetching products: $e");
    }
    filteredProducts.value = products;
  }

  void searchProducts(String query) {
    filteredProducts.value = products
        .where((product) =>
            product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
