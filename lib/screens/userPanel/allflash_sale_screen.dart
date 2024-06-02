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

class AllFlashSaleScreen extends StatefulWidget {
  const AllFlashSaleScreen({super.key});

  @override
  State<AllFlashSaleScreen> createState() => _AllFlashSaleScreenState();
}

class _AllFlashSaleScreenState extends State<AllFlashSaleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppConstants.appSecondColor,
        appBar: AppBar(
          backgroundColor: AppConstants.appSecondColor,
          title: Text("Discounts & Sales 💰",
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
                .where('isSale', isEqualTo: true)
                .get(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                  child: Text(
                    "No Products found",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
              if (snapshot.data != null) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        childAspectRatio: 0.7,
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
                                  width: Get.width / 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: Get.width / 3.5,
                                        height: Get.height / 5,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                AppConstants.appSecondaryColor),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: CachedNetworkImage(
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
