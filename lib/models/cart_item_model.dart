// cart_item_model.dart

import 'products_model.dart'; // Import the Product model

class CartItem {
  final Product product; // Now the Product type is defined
  final int quantity;

  CartItem({required this.product, required this.quantity});

  CartItem copyWith({Product? product, int? quantity}) {
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
      product: Product.fromMap(map['product']),
      quantity: map['quantity'],
    );
  }
}
