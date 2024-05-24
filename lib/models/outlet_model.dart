import 'package:cloud_firestore/cloud_firestore.dart';

class Outlet {
  final String id;
  final String name;
  final String address;
  final GeoPoint location;
  final String brandedShopId;
  final double? rating;
  final String imageUrl;

  Outlet(
      {required this.id,
      required this.name,
      required this.address,
      required this.location,
      required this.brandedShopId,
      this.rating,
      required this.imageUrl});

  factory Outlet.fromMap(Map<String, dynamic> map) {
    return Outlet(
      id: map['outletId'],
      name: map['name'],
      address: map['address'],
      location: map['location'],
      brandedShopId: map['brandedShopId'],
      rating: map['rating']?.toDouble(),
      imageUrl: map['imageUrl'],
    );
  }
}
