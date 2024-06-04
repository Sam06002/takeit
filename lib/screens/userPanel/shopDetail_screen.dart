// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:takeit/utils/app_constants.dart';

import '../../controllers/shop_detail_controller.dart';

import '../../models/product_model.dart/product_model.dart';

import '../../models/shop_model.dart';
import '../../widgets/banner_widget.dart';
import '../../widgets/categories_widget.dart';
import '../../widgets/flashSale_widget.dart';
import '../../widgets/headings_widget.dart';
import '../../widgets/productCard_widget.dart';
import 'allcategories_screen.dart';
import 'allflash_sale_screen.dart';
import 'cart_screen.dart';

class ShopDetailScreen extends StatelessWidget {
  final String shopId;

  const ShopDetailScreen({
    super.key,
    required this.shopId,
  });

  @override
  Widget build(BuildContext context) {
    final shopDetailController = Get.find<ShopDetailController>();

    return Scaffold(
      backgroundColor: AppConstants.appSecondColor,
      appBar: AppBar(
        backgroundColor: AppConstants.appSecondColor,
        title: Obx(() =>
            Text(shopDetailController.shop?.name ?? "Loading Shop Details",
                style: GoogleFonts.spaceGrotesk(
                    textStyle: const TextStyle(
                        color: AppConstants.appMainColor,
                        fontSize: 20,
                        //letterSpacing: .5,
                        fontWeight: FontWeight.w500)))),
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
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: BannerWidget(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HeadingWidget(
                      title: "Daily Essentials 🧺",
                      onTap: () => Get.to(() => const AllCategoriesScreen()),
                      subTitle: "See all"),
                ),
                const CategoriesWidget(),

                TextField(
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
                  height: 50,
                ),
                // Add spacing between search bar and list
                Obx(
                  () => shopDetailController.shop != null
                      ? _buildProductList(shopDetailController.filteredProducts
                          as List<ProductModel>) // Use the filtered list
                      : const Center(
                          child: CircularProgressIndicator(
                          color: AppConstants.appYellowColor,
                        )),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
          child: const Icon(Icons.shopping_cart),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        surfaceTintColor: AppConstants.appSecondColor,
        elevation: 10,
        shadowColor: AppConstants.appSecondColor,
        notchMargin: 5.0,
        shape: const CircularNotchedRectangle(),
        color: AppConstants.appSecondColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(
                    Icons.home_filled,
                    color: Colors.white,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.account_box_rounded,
                    color: Colors.white,
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildShopDetails(Shop shop) {
    final ShopDetailController shopDetailController =
        Get.put(ShopDetailController(
      shopId: shopId,
    ));
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Shop details (name, address, image, etc.)
        Obx(() => shopDetailController.products.isNotEmpty
            ? _buildProductList(shopDetailController.products)
            : const Center(child: Text('No products available'))),
      ],
    );
  }

  Widget _buildProductList(List<ProductModel> products) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Two columns
        childAspectRatio: 0.5,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: products.length,
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
