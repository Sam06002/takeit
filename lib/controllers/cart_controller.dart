import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:takeit/models/product_model.dart/product_model.dart';

import '../models/cart_item_model.dart';

import '../models/order_model.dart' as orm;

class CartController extends GetxController {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final cartItems = RxList<CartItem>([]);

  Future<void> placeOrder(String shopId) async {
    try {
      final orderId = "ORDER_${DateTime.now().millisecondsSinceEpoch}";
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final orderData = orm.Order(
        orderId: orderId,
        customerId: userId,
        shopId: shopId,
        items: cartItems.map((item) => item.toMap()).toList(),
        totalPrice: _calculateTotalPrice(), // You'll need to implement this
        orderStatus: 'pending',
        timestamp: FieldValue.serverTimestamp(),
      );

      // Create order document in Firestore
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(orderId)
          .set(orderData.toMap());

      // Send FCM notification to merchant
      await _sendNotificationToMerchant(
        shopId,
      ); // Add this function

      // Clear the cart
      cartItems.clear();

      // Optional: Navigate to order confirmation screen
      Get.snackbar('Order placed!', 'Your order has been sent to the shop.',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      // Handle errors (e.g., show error message)
      print('Error placing order: $e');
    }
  }

  int getProductQuantity(String productId) {
    final index =
        cartItems.indexWhere((item) => item.product.productId == productId);
    if (index != -1) {
      return cartItems[index].quantity;
    } else {
      return 0;
    }
  }

  // Function to add product to the cart
  void addToCart(ProductModel product) {
    final existingItemIndex = cartItems
        .indexWhere((item) => item.product.productId == product.productId);
    if (existingItemIndex != -1) {
      cartItems[existingItemIndex] = cartItems[existingItemIndex].copyWith(
        quantity: cartItems[existingItemIndex].quantity + 1,
      );
    } else {
      cartItems.add(CartItem(product: product, quantity: 1));
    }
  }

  // Function to remove product from the cart
  void removeFromCart(String productId) {
    cartItems.removeWhere((item) => item.product.productId == productId);
  }

  // Function to update quantity of a product in the cart
  void updateQuantity(String productId, int newQuantity) {
    final index =
        cartItems.indexWhere((item) => item.product.productId == productId);
    if (index != -1) {
      cartItems[index] = cartItems[index].copyWith(quantity: newQuantity);
    }
  }

  double _calculateTotalPrice() {
    return 1;
    // ... your price calculation logic ...
  }

  Future<void> _sendNotificationToMerchant(
    String shopId,
  ) async {
    // ... your notification logic ...
  }
}
