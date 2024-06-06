// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:takeit/screens/userPanel/cart_screen.dart';
import 'package:takeit/utils/app_constants.dart';
import 'package:takeit/widgets/productCard_widget.dart';

import '../../models/categories_model.dart';
import '../../models/product_model.dart/product_model.dart';
import 'controllers/cart_controller.dart';
import 'controllers/shop_detail_controller.dart';

class DemoSingleCategoryProductScreen extends StatefulWidget {
  String categoryId;
  String categoryImg;
  DemoSingleCategoryProductScreen({
    super.key,
    required this.categoryId,
    required this.categoryImg,
  });

  @override
  State<DemoSingleCategoryProductScreen> createState() =>
      SingleCategoryProductsScreenState();
}

class SingleCategoryProductsScreenState
    extends State<DemoSingleCategoryProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppConstants.appSecondColor,
        appBar: AppBar(
          backgroundColor: AppConstants.appSecondColor,
          title: Text('Products 🛍️',
              style: GoogleFonts.spaceGrotesk(
                  textStyle: const TextStyle(
                      color: AppConstants.appYellowColor,
                      fontSize: 25,
                      //letterSpacing: .5,
                      fontWeight: FontWeight.w100))),
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: AppConstants.appYellowColor,
              )),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(5.0),
          child: FloatingActionButton(
            shape: const CircleBorder(),
            backgroundColor: AppConstants.appYellowColor,
            foregroundColor: AppConstants.appMainColor,
            onPressed: () {
              Vibrate.feedback(FeedbackType.selection);
              showModalBottomSheet(
                  backgroundColor: Colors.black,
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      decoration: const BoxDecoration(
                          color: AppConstants.appSecondColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25))),
                      height: Get.height / 2,
                      child: const CartScreen(),
                    );
                  });
            },
            child: const Icon(
              Icons.shopping_cart,
              color: Colors.black,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('products')
                  .where('categoryId', isEqualTo: widget.categoryId)
                  .get(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Error"),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: Get.height / 5,
                    child: const Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  );
                }
                if (snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text("No category found"),
                  );
                }
                if (snapshot.data != null) {
                  return GridView.builder(
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 3,
                        childAspectRatio: 0.9,
                        crossAxisSpacing: 3,
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) {
                        final itemCount = snapshot.data!.docs.length;
                        final productData = snapshot.data!.docs[index];
                        ProductModel productModel = ProductModel(
                            productId: productData['productId'],
                            categoryId: productData['categoryId'],
                            productName: productData['productName'],
                            categoryName: productData['categoryName'],
                            salePrice: productData['salePrice'],
                            fullPrice: productData['fullPrice'],
                            productImages: productData['productImages'],
                            deliveryTime: productData['deliveryTime'],
                            isSale: productData['isSale'],
                            productDescription:
                                productData['productDescription'],
                            createdAt: productData['createdAt'],
                            updatedAt: productData['updatedAt']);
                        return ProductCard(
                            product: productModel,
                            onAddToCart: () {
                              Get.snackbar(
                                'Added to Cart',
                                '${productModel.productName} has been added to your cart.',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            });
                      });
                }
                return Container();
              }),
        ));
  }

  Widget buildProductList(products, iindex) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Two columns
        childAspectRatio: 0.8,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: iindex,
      itemBuilder: (context, iindex) {
        final product = products[iindex];
        return ProductCard(
            product: product,
            onAddToCart: () {
              Get.snackbar(
                'Added to Cart',
                '${product.productName} has been added to your cart.',
                snackPosition: SnackPosition.BOTTOM,
              );
            }); // Use the ProductCard widget
      },
    );
  }
}
