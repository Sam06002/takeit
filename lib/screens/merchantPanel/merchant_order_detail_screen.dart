import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/order_controller.dart';
import '../../models/order_model.dart' as orm;

class MerchantOrderDetailsScreen extends StatelessWidget {
  final orm.Order order;

  MerchantOrderDetailsScreen({Key? key, required this.order}) : super(key: key);
  final OrderController orderController =
      Get.find<OrderController>(); // Get the OrderController instance

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order ID: #${order.orderId}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Customer ID: ${order.customerId}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Order Status: ${order.orderStatus}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text('Items:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _buildOrderItemsList(order),
            SizedBox(height: 20),
            Text('Total Price: Rs ${order.totalPrice.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            _buildActionButtons(order), // Call the _buildActionButtons function
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItemsList(orm.Order order) {
    return Column(
      children: order.items.map((item) {
        final productId = item['productId'];
        final quantity = item['quantity'];

        return FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('products')
              .doc(productId)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final productData = snapshot.data!.data() as Map<String, dynamic>;
              return ListTile(
                title: Text(productData['name']),
                subtitle: Text('Quantity: $quantity'),
                trailing: Text(
                    'Rs ${(productData['price'] as num).toDouble().toStringAsFixed(2)}'),
              );
            }
          },
        );
      }).toList(),
    );
  }

  Widget _buildActionButtons(orm.Order order) {
    // Check order status and return appropriate buttons
    if (order.orderStatus == 'pending') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: () => orderController.acceptOrder(order.orderId),
            child: const Text('Accept'),
          ),
          ElevatedButton(
            onPressed: () => orderController.rejectOrder(order.orderId),
            child: const Text('Reject'),
          ),
        ],
      );
    } else if (order.orderStatus == 'accepted') {
      return ElevatedButton(
        onPressed: () => orderController.packOrder(order.orderId),
        child: const Text('Mark as Packed'),
      );
    } else {
      return Container(); // No buttons for other statuses
    }
  }
}
