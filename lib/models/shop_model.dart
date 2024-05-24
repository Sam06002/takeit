import 'package:cloud_firestore/cloud_firestore.dart';

class Shop {
  final String shopId;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final String geohash; // For GeoFirestore queries (if applicable)
  final bool isOpen;
  final num rating;
  final String category;
  final image;

  Shop(
      {required this.shopId,
      required this.name,
      required this.address,
      required this.latitude,
      required this.longitude,
      required this.geohash,
      required this.isOpen,
      required this.rating,
      required this.category,
      required this.image});

  factory Shop.fromMap(Map<String, dynamic> json) {
    GeoPoint location = json['location'];
    return Shop(
      shopId: json['shopId'],
      name: json['name'],
      address: json['address'],
      latitude: location.latitude,
      longitude: location.longitude,
      geohash: json['geohash'],
      isOpen: json['isOpen'],
      rating: json['rating'],
      category: json['category'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'shopId': shopId,
      'name': name,
      'address': address,
      'location': GeoPoint(latitude, longitude), // Assuming GeoPoint type
      'geohash': geohash,
      'isOpen': isOpen,
      'rating': rating,
      'category': category,
      'image': image,
    };
  }

  Shop copyWith({
    String? shopId,
    String? name,
    String? address,
    double? latitude,
    double? longitude,
    String? geohash,
    bool? isOpen,
    double? rating,
    String? category,
    String? image,
  }) {
    return Shop(
      shopId: shopId ?? this.shopId,
      name: name ?? this.name,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      geohash: geohash ?? this.geohash,
      isOpen: isOpen ?? this.isOpen,
      rating: rating ?? this.rating,
      category: category ?? this.category,
      image: image ?? this.image,
    );
  }
}
