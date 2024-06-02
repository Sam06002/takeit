import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:takeit/utils/app_constants.dart';

import '../../models/categories_model.dart';
import '../../models/product_model.dart/product_model.dart';

class SingleCategoryProductsScreen extends StatefulWidget {
  String categoryId;
  String categoryImg;
  SingleCategoryProductsScreen({
    super.key,
    required this.categoryId,
    required this.categoryImg,
  });

  @override
  State<SingleCategoryProductsScreen> createState() =>
      SingleCategoryProductsScreenState();
}

class SingleCategoryProductsScreenState
    extends State<SingleCategoryProductsScreen> {
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
                        return Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(30),
                              child: GestureDetector(
                                  onTap: () {
                                    // fetch shops by category
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        width: Get.width / 4,
                                        height: Get.height / 9,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                AppConstants.appSecondaryColor),
                                        child: Padding(
                                          padding: const EdgeInsets.all(1.0),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                productModel.productImages[0],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: Get.width / 4,
                                        child: Text(
                                          productModel.productName,
                                          overflow: TextOverflow.ellipsis,
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
                                  )),
                            )
                          ],
                        );
                      });
                }
                return Container();
              }),
        ));
  }
}
