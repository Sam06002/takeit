import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:takeit/controllers/order_controller.dart';

import '../../models/order_model.dart';
import '../authUI/welcome_screen.dart';
import 'merchant_order_detail_screen.dart';

class MerchantScreen extends StatefulWidget {
  const MerchantScreen({Key? key}) : super(key: key);

  @override
  State<MerchantScreen> createState() => _MerchantScreenState();
}

class _MerchantScreenState extends State<MerchantScreen> {
  final OrderController orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          child: const Text("Merchant Dashboard"),
          onTap: () async {
            GoogleSignIn googleSignIn = GoogleSignIn();
            // ignore: no_leading_underscores_for_local_identifiers
            FirebaseAuth _auth = FirebaseAuth.instance;
            await _auth.signOut();
            await googleSignIn.signOut();
            Get.offAll(() => WelcomeScreen());
          },
        ), // Update title
      ),
      body: Obx(() => orderController.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : _buildOrderList(orderController.orders as List<Order>)),
    );
  }

  Widget _buildOrderList(List<Order> orders) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return ListTile(
          title: Text('Order #${order.orderId}'),
          subtitle:
              Text('Customer: ${order.customerId}'), // Or an anonymized ID
          trailing: _buildOrderStatusActions(order),
          onTap: () => Get.to(() =>
              MerchantOrderDetailsScreen(order: order)), // Navigate to details
        );
      },
    );
  }

  Widget _buildOrderStatusActions(Order order) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        // Handle order actions here (accept, reject, pack, etc.)
        if (value == 'accept') {
          orderController.acceptOrder(order.orderId);
        } else if (value == 'reject') {
          orderController.rejectOrder(order.orderId);
        } else if (value == 'pack') {
          orderController.packOrder(order.orderId);
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(value: 'accept', child: Text('Accept')),
        const PopupMenuItem(value: 'reject', child: Text('Reject')),
        const PopupMenuItem(value: 'pack', child: Text('Mark as Packed')),
      ],
    );
  }
}
