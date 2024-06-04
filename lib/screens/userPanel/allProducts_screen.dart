import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/categories_model.dart';
import '../../models/product_model.dart/product_model.dart';
import '../../utils/app_constants.dart';
import 'single_category_products_screen.dart';

class AllProductScreen extends StatefulWidget {
  const AllProductScreen({super.key});

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppConstants.appSecondColor,
        appBar: AppBar(
          backgroundColor: AppConstants.appSecondColor,
          title: Text("All Products 🛍️",
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
        body: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('products')
                .where('isSale', isEqualTo: false)
                .get(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Error"),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  height: Get.height / 5,
                  child: const Center(
                    child: CupertinoActivityIndicator(),
                  ),
                );
              }
              if (snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text(
                    "No Products found",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
              if (snapshot.data != null) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 50),
                  child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        childAspectRatio: 0.75,
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

                        return Row(
                          children: [
                            GestureDetector(
                                onTap: () {},
                                child: SizedBox(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: Get.width / 3.5,
                                        height: Get.height / 7,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                AppConstants.appSecondaryColor),
                                        child: Padding(
                                          padding: const EdgeInsets.all(1.0),
                                          child: CachedNetworkImage(
                                            fit: BoxFit.contain,
                                            imageUrl:
                                                productModel.productImages[0],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width: Get.width / 3.5,
                                        child: Text(
                                          productModel.productName,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: GoogleFonts.spaceGrotesk(
                                              textStyle: const TextStyle(
                                                  color:
                                                      AppConstants.appMainColor,
                                                  fontSize: 12,
                                                  //letterSpacing: .5,
                                                  fontWeight: FontWeight.w100)),
                                        ),
                                      ),
                                      Container(
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Text(
                                          '  Rs ${productModel.fullPrice}',
                                          style: GoogleFonts.spaceGrotesk(
                                              textStyle: const TextStyle(
                                                  color: AppConstants
                                                      .appYellowColor,
                                                  fontSize: 10,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  //letterSpacing: .5,
                                                  fontWeight: FontWeight.w100)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                          ],
                        );
                      }),
                );
              }
              return Container();
            }));
  }
}
