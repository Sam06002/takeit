// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
                        crossAxisSpacing: 3,
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) {
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
                        return Expanded(
                          // Make the list take up the remaining space
                          child: Obx(() => buildProductList(
                                  productModel, index) // Use the filtered list

                              ),
                        );
                      });
                }
                return Container();
              }),
        ));
  }

  Widget buildProductList(products, iindex) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Two columns
        childAspectRatio: 0.5,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: iindex,
      itemBuilder: (context, index) {
        final product = products[index];
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
