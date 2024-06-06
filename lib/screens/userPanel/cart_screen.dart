import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:takeit/controllers/cart_controller.dart';
import 'package:takeit/models/cart_item_model.dart';
import 'package:takeit/screens/userPanel/dashboard.dart';

import 'package:takeit/utils/app_constants.dart';

// Import your route helper

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  VoidCallback? _onTapHandler;
  @override
  void initState() {
    super.initState();
    _onTapHandler = _handleTap; // Initialize with your tap handler
  }

  void _handleTap() async {
    final CartController cartController = Get.find();

    if (cartController.cartItems.isNotEmpty) {
      EasyLoading.show(status: "Get Ready to Take it");
      String shopId = 'vxfnauCLtKhFRlyRluv0';
      setState(() {
        _onTapHandler = null; // Remove the callback after the first tap
      }); //247 Shop Id
      try {
        await cartController.placeOrder(
            shopId); // Pass the shopId from which the items were added
        Get.snackbar(
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
          'Order Placed',
          'Your order has been placed successfully!',
          snackPosition: SnackPosition.BOTTOM,
        );
        EasyLoading.dismiss(animation: false);

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

    // Your original tap logic (e.g., placing the order)
  }

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
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: () {
                  cartController.clearCart();
                },
                child: const Icon(
                  Icons.cancel_outlined,
                  color: Colors.red,
                )),
          )
        ],
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
                    return Card(
                      elevation: 5,
                      color: AppConstants.appSecondaryColor,
                      child: ListTile(
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
        onTap: _onTapHandler,
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
