import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/order_model.dart' as orm;

class OrderController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Assuming the merchant ID is the same as the user ID

  RxList<orm.Order> orders = <orm.Order>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPendingOrders();
  }

  Future<void> fetchPendingOrders() async {
    try {
      final snapshot = await _firestore
          .collection('orders')
          .where('shopId', isEqualTo: 'C4iO9SKkFsFnViEo8YIi')
          .where('orderStatus', isEqualTo: 'pending')
          .get();

      orders.value =
          snapshot.docs.map((doc) => orm.Order.fromMap(doc.data())).toList();
    } catch (e) {
      // Handle errors
      print('Error fetching orders: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void acceptOrder(String orderId) async {
    try {
      await _firestore
          .collection('orders')
          .doc(orderId)
          .update({'orderStatus': 'accepted'});
      // You can add a notification to the customer here if needed
      // ...
    } catch (e) {
      // Handle errors (show error message, etc.)
      print('Error accepting order: $e');
    }
  }

  void rejectOrder(String orderId) async {
    try {
      await _firestore
          .collection('orders')
          .doc(orderId)
          .update({'orderStatus': 'rejected'});
      // You can add a notification to the customer here if needed
      // ...
    } catch (e) {
      // Handle errors (show error message, etc.)
      print('Error rejecting order: $e');
    }
  }

  void packOrder(String orderId) async {
    try {
      await _firestore
          .collection('orders')
          .doc(orderId)
          .update({'orderStatus': 'packed'});
      // You can add a notification to the customer here if needed
      // ...
    } catch (e) {
      // Handle errors (show error message, etc.)
      print('Error packing order: $e');
    }
  }

  // ... (implement acceptOrder, rejectOrder, packOrder functions that update order status in Firestore and send notifications)
}
