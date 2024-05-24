class ShopLoc {
  final String shopId;
  final double latitude;
  final double longitude;
  String shopName;

  ShopLoc(
      {required this.shopId,
      required this.latitude,
      required this.longitude,
      required this.shopName});

  factory ShopLoc.fromJson(Map<String, dynamic> json) {
    return ShopLoc(
        shopName: json['shopName'],
        shopId: json['shopId'],
        latitude: json['latitude'],
        longitude: json['longitude']);
  }
}
