import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  final String orderId;
  final String customerId;
  final String shopId;
  final List<Map<String, dynamic>>
      items; // Assuming CartItem.toMap() returns a Map
  final double totalPrice;
  final String orderStatus;
  final FieldValue timestamp;

  Order({
    required this.orderId,
    required this.customerId,
    required this.shopId,
    required this.items,
    required this.totalPrice,
    required this.orderStatus,
    required this.timestamp,
  });
  static Order fromMap(Map<String, dynamic> data) {
    return Order(
      orderId: data['orderId'],
      totalPrice: data['totalPrice'],
      items: data['items'],
      timestamp: data['timestamp'],

      shopId: data['shopId'],
      customerId: data['customerId'],
      orderStatus: data['orderStatus'],
      // ... (add additional properties)
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'customerId': customerId,
      'shopId': shopId,
      'items': items,
      'totalPrice': totalPrice,
      'orderStatus': orderStatus,
      'timestamp': timestamp,
      'orderId': orderId,
      // ... (add additional properties)'
    };
  }
}
