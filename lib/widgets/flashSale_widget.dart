// ignore_for_file: avoid_unnecessary_containers

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:takeit/models/product_model.dart/product_model.dart';

import 'package:takeit/utils/app_constants.dart';

class FlashSaleWidget extends StatelessWidget {
  const FlashSaleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: FutureBuilder(
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
              return SizedBox(
                height: Get.height / 5,
                child: const Center(
                  child: CupertinoActivityIndicator(),
                ),
              );
            }
            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text("No products found"),
              );
            }
            if (snapshot.data != null) {
              return SizedBox(
                height: Get.height / 4,
                child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
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
                          productDescription: productData['productDescription'],
                          createdAt: productData['createdAt'],
                          updatedAt: productData['updatedAt']);
                      return Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: GestureDetector(
                                onTap: () {
                                  // fetch shops by category
                                },
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: Get.height / 7,
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
                                      Text(
                                        productModel.productName,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.spaceGrotesk(
                                            textStyle: const TextStyle(
                                                color:
                                                    AppConstants.appMainColor,
                                                fontSize: 12,
                                                overflow: TextOverflow.ellipsis,
                                                //letterSpacing: .5,
                                                fontWeight: FontWeight.w100)),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Rs ${productModel.salePrice} ',
                                            style: GoogleFonts.spaceGrotesk(
                                                textStyle: const TextStyle(
                                                    color: AppConstants
                                                        .appYellowColor,
                                                    fontSize: 12,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    //letterSpacing: .5,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ),
                                          Container(
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                color:
                                                    AppConstants.appThirdColor),
                                            child: Text(
                                              '  Rs ${productModel.fullPrice}',
                                              style: GoogleFonts.spaceGrotesk(
                                                  textStyle: const TextStyle(
                                                      color: AppConstants
                                                          .appSecondColor,
                                                      fontSize: 10,
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      //letterSpacing: .5,
                                                      fontWeight:
                                                          FontWeight.w100)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                          )
                        ],
                      );
                    }),
              );
            }
            return Container();
          }),
    );
  }
}
