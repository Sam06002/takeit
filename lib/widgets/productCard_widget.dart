// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:takeit/controllers/cart_controller.dart';
import 'package:takeit/models/product_model.dart/product_model.dart';

import 'package:takeit/utils/app_constants.dart';

class ProductCard extends StatefulWidget {
  final ProductModel product;
  final VoidCallback onAddToCart;
  // Callback for adding to cart

  const ProductCard(
      {super.key, required this.product, required this.onAddToCart});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isAddedToCart = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(186, 25, 38, 47),
      child: Center(
        child: InkWell(
          focusColor: AppConstants.appSecondColor,
          onLongPress: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: CachedNetworkImage(
                  imageUrl: widget.product.productImages[0],
                  fit: BoxFit.contain,
                ),
              ),
            );
            // (Optional) Navigate to a product detail screen
          },
          child: Container(
            padding: const EdgeInsets.all(3),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.product.productImages.isNotEmpty)
                    CachedNetworkImage(
                      imageUrl: widget.product.productImages[0],
                      height: Get.height / 15,
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
                    widget.product.productName,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    style: GoogleFonts.spaceGrotesk(
                        textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            //letterSpacing: .5,
                            fontWeight: FontWeight.w200)),
                  ),
                  if (widget.product.productDescription.isNotEmpty)
                    Text(widget.product.productDescription,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.spaceGrotesk(
                            textStyle: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 12,
                                //letterSpacing: .5,
                                fontWeight: FontWeight.w100))),
                  SizedBox(
                    height: 5,
                    width: Get.width / 2.5,
                  ),
                  Text('Rs ${widget.product.fullPrice}',
                      style: GoogleFonts.spaceGrotesk(
                          textStyle: TextStyle(
                              color: Colors.green[400],
                              fontSize: 15,
                              //letterSpacing: .5,
                              fontWeight: FontWeight.w500))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(
                        width: 50,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.put(CartController()).addToCart(widget.product);
                          Vibrate.feedback(FeedbackType.selection);
                          setState(() {
                            isAddedToCart = true; // Update state after adding
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isAddedToCart
                                    ? Colors.green[400]
                                    : AppConstants.appYellowColor),
                            child: Icon(
                                size: 20,
                                isAddedToCart ? Icons.check_circle : Icons.add,
                                color: isAddedToCart
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
