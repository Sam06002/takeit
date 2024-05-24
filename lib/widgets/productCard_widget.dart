// ignore_for_file: file_names
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:takeit/utils/app_constants.dart';

import '../controllers/cart_controller.dart';
import '../models/products_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onAddToCart; // Callback for adding to cart

  const ProductCard(
      {super.key, required this.product, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppConstants.appSecondaryColor,
      elevation: 4,
      child: Center(
        child: InkWell(
          focusColor: Colors.transparent,
          onTap: () {
            // (Optional) Navigate to a product detail screen
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (product.image != null && product.image!.isNotEmpty)
                  CachedNetworkImage(
                    imageUrl: product.image!,
                    height: Get.height / 5,
                    width: Get.width / 2.5,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )
                else
                  Container(
                    height: Get.height / 5,
                    width: Get.width / 2.5,
                    color: AppConstants.appMainColor, // Placeholder color
                  ),
                const SizedBox(height: 10),
                Text(
                  product.name,
                  style: GoogleFonts.spaceGrotesk(
                      textStyle: const TextStyle(
                          color: AppConstants.appYellowColor,
                          fontSize: 20,
                          //letterSpacing: .5,
                          fontWeight: FontWeight.w500)),
                ),
                if (product.description.isNotEmpty)
                  Text(product.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.spaceGrotesk(
                          textStyle: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 13,
                              //letterSpacing: .5,
                              fontWeight: FontWeight.w100))),
                SizedBox(
                  height: 5,
                  width: Get.width / 2.5,
                ),
                Text('Rs ${product.price.toStringAsFixed(2)}',
                    style: GoogleFonts.spaceGrotesk(
                        textStyle: TextStyle(
                            color: Colors.green[400],
                            fontSize: 15,
                            //letterSpacing: .5,
                            fontWeight: FontWeight.w500))),
                Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                        surfaceTintColor: MaterialStateColor.resolveWith(
                            (states) => AppConstants.appSecondColor),
                        backgroundColor: MaterialStateProperty.all(
                          AppConstants.appSecondColor,
                        )),
                    onPressed: () {
                      Get.put(CartController()).addToCart(product);
                      Vibrate.feedback(FeedbackType.selection);
                    },
                    child: Container(
                      width: Get.width / 1,
                      height: 35,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppConstants.appSecondColor,
                      ),
                      child: const Icon(
                        Icons.add_shopping_cart,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
