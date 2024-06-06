import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/shop_detail_controller.dart';
import '../../models/product_model.dart/product_model.dart';
import '../../utils/app_constants.dart';
import '../../widgets/banner_widget.dart';
import '../../widgets/productCard_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final shopDetailController = Get.find<ShopDetailController>();
    return KeyboardVisibilityBuilder(builder: (context, isKeyBoardVisible) {
      return Scaffold(
        backgroundColor: AppConstants.appSecondColor,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back,
                color: AppConstants.appYellowColor),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            "Find your product 🛒",
            style: GoogleFonts.spaceGrotesk(
                textStyle: const TextStyle(
                    color: AppConstants.appYellowColor,
                    fontSize: 25,
                    //letterSpacing: .5,
                    fontWeight: FontWeight.w500)),
          ),
          backgroundColor: AppConstants.appSecondColor,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            // Add padding for better spacing
            padding: const EdgeInsets.all(5.0),
            child: Container(
              color: AppConstants.appSecondColor,
              child: Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  TextField(
                    style: GoogleFonts.spaceGrotesk(
                        textStyle: const TextStyle(
                            color: AppConstants.appYellowColor,
                            fontSize: 15,
                            //letterSpacing: .5,
                            fontWeight: FontWeight.w500)),
                    autocorrect: true,
                    // Search bar in the body
                    controller: shopDetailController.searchController,
                    onChanged: (query) =>
                        shopDetailController.searchProducts(query),
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        borderSide: BorderSide(
                            color: AppConstants.appSecondColor, width: 1.0),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        borderSide: BorderSide(
                            color: AppConstants.appSecondColor, width: 1.0),
                      ),
                      hintText: 'Search products',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      prefixIcon: const Icon(Icons.search),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: AppConstants.appSecondaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),

                  isKeyBoardVisible
                      ? Obx(
                          () => shopDetailController.shop != null
                              ? _buildProductList(
                                  shopDetailController.filteredProducts as List<
                                      ProductModel>) // Use the filtered list
                              : const Center(
                                  child: CircularProgressIndicator(
                                  color: AppConstants.appYellowColor,
                                )),
                        )
                      : Column(
                          children: [
                            const SizedBox(height: 10),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: BannerWidget(),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Obx(
                              () => shopDetailController.shop != null
                                  ? _buildProductList(shopDetailController
                                          .filteredProducts
                                      as List<
                                          ProductModel>) // Use the filtered list
                                  : const Center(
                                      child: CircularProgressIndicator(
                                      color: AppConstants.appYellowColor,
                                    )),
                            )
                          ],
                        ),

                  const SizedBox(
                    height: 5,
                  ),

                  // Add spacing between search bar and list
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildProductList(List<ProductModel> products) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Two columns
        childAspectRatio: 1,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: 2,
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
