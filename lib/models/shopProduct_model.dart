// ignore: file_names
class ShopProduct {
  final String shopProductId;
  final String shopId;
  final String productId;
  final num price;
  final int inventoryQuantity;

  ShopProduct(
      {required this.shopProductId,
      required this.shopId,
      required this.productId,
      required this.price,
      required this.inventoryQuantity});

  factory ShopProduct.fromMap(Map<String, dynamic> json) {
    return ShopProduct(
      shopProductId: json['shopProductId'],
      shopId: json['shopId'],
      productId: json['productId'],
      price: json['price'].toDouble(),
      inventoryQuantity: json['inventoryQuantity'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'shopProductId': shopProductId,
      'shopId': shopId,
      'productId': productId,
      'price': price,
      'inventoryQuantity': inventoryQuantity,
    };
  }
}
