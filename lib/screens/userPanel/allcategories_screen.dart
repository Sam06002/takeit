import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:takeit/screens/userPanel/single_category_products_screen.dart';
import 'package:takeit/utils/app_constants.dart';

import '../../models/categories_model.dart';

class AllCategoriesScreen extends StatefulWidget {
  const AllCategoriesScreen({super.key});

  @override
  State<AllCategoriesScreen> createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<AllCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppConstants.appSecondColor,
        appBar: AppBar(
          backgroundColor: AppConstants.appSecondColor,
          title: Text("Daily Essentials 🧺",
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
            future: FirebaseFirestore.instance.collection('categories').get(),
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
                  child: Text("No category found"),
                );
              }
              if (snapshot.data != null) {
                return Center(
                  child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 20,
                        crossAxisCount: 3,
                      ),
                      itemBuilder: (context, index) {
                        CategoriesModel categoriesModel = CategoriesModel(
                          categoryDescription: snapshot.data!.docs[index]
                              ['categoryDescription'],
                          categoryId: snapshot.data!.docs[index]['categoryId'],
                          categoryImg: snapshot.data!.docs[index]
                              ['categoryImg'],
                          categoryName: snapshot.data!.docs[index]
                              ['categoryName'],
                          createdAt: snapshot.data!.docs[index]['createdAt'],
                          updatedAt: snapshot.data!.docs[index]['updatedAt'],
                        );
                        return Row(
                          children: [
                            GestureDetector(
                                onTap: () =>
                                    Get.to(() => SingleCategoryProductsScreen(
                                          categoryId:
                                              categoriesModel.categoryId,
                                          categoryImg:
                                              categoriesModel.categoryImg,
                                        )),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: Get.width / 3.5,
                                      height: Get.height / 10,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:
                                              AppConstants.appSecondaryColor),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: CachedNetworkImage(
                                          imageUrl: categoriesModel.categoryImg,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: Get.width / 3.5,
                                      child: Text(
                                        categoriesModel.categoryName,
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
