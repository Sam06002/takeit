import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:takeit/controllers/cart_controller.dart';
import 'package:takeit/screens/userPanel/dashboard.dart';

import 'package:takeit/utils/app_constants.dart';

// Import your route helper

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text("Cart",
            style: GoogleFonts.spaceGrotesk(
                textStyle: const TextStyle(
                    color: AppConstants.appSecondColor,
                    fontSize: 20,
                    //letterSpacing: .5,
                    fontWeight: FontWeight.w500))),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: cartController.cartItems.length,
          itemBuilder: (context, index) {
            final item = cartController.cartItems[index];
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('products')
                  .doc(item.product.productId)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final productData =
                      snapshot.data!.data() as Map<String, dynamic>?;
                  if (productData != null) {
                    return ListTile(
                      leading: Image.network(
                          productData['productImages'][0] as String),
                      title: Text(productData['productName'] as String),
                      subtitle: Text(
                        "Rs ${(productData['fullPrice'] as String)}",
                        style: GoogleFonts.spaceGrotesk(
                          textStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () => cartController.updateQuantity(
                                item.product.productId, item.quantity - 1),
                          ),
                          Text(item.quantity.toString()),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () => cartController.updateQuantity(
                                item.product.productId, item.quantity + 1),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                } else {
                  return const CircularProgressIndicator();
                }
              },
            );
          },
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () async {
          if (cartController.cartItems.isNotEmpty) {
            String shopId = cartController.cartItems.first.product.productId;
            try {
              await cartController.placeOrder(
                  shopId); // Pass the shopId from which the items were added
              Get.snackbar(
                'Order Placed',
                'Your order has been placed successfully!',
                snackPosition: SnackPosition.BOTTOM,
              );
              // Optional: Navigate to order confirmation screen
              Get.to(() => const DashBoard());
            } catch (e) {
              // Handle errors during order placement
              print("Error placing order: $e");
            }
          } else {
            // Show a message if the cart is empty
            Get.snackbar(
              'Empty Cart',
              'Please add items to your cart before placing an order.',
              snackPosition: SnackPosition.BOTTOM,
            );
          }
        },
        child: Material(
          elevation: 10,
          child: Container(
            padding: const EdgeInsets.all(10),
            height: Get.height / 10,
            width: Get.width,
            color: AppConstants.appSecondColor,
            child: Center(
              child: Text("Place Order",
                  style: GoogleFonts.spaceGrotesk(
                      textStyle: const TextStyle(
                          color: AppConstants.appMainColor,
                          fontSize: 20,
                          //letterSpacing: .5,
                          fontWeight: FontWeight.w500))),
            ),
          ),
        ),
      ),
    );
  }
}
