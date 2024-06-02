// cart_item_model.dart

// Import the Product model

import 'package:takeit/models/product_model.dart/product_model.dart';

class CartItem {
  final ProductModel product; // Now the Product type is defined
  final int quantity;

  CartItem({required this.product, required this.quantity});

  CartItem copyWith({ProductModel? product, int? quantity}) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': product.productId,
      'quantity': quantity,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      product: ProductModel.fromMap(map['product']),
      quantity: map['quantity'],
    );
  }
}
