import 'package:cloud_firestore/cloud_firestore.dart';

class BrandedShop {
  final String id;
  final String name;
  final String category;
  final String logo;

  BrandedShop({
    required this.id,
    required this.name,
    required this.category,
    required this.logo,
  });

  factory BrandedShop.fromDocumentSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return BrandedShop(
      id: doc.id,
      name: data['name'],
      category: data['category'],
      logo: data['logo'],
    );
  }
  factory BrandedShop.fromMap(Map<String, dynamic> map) {
    return BrandedShop(
      id: map['brandedShopId'], // Assuming your document ID is "brandedShopId"
      name: map['name'],
      category: map['category'],
      logo: map['logo'],
    );
  }
}
