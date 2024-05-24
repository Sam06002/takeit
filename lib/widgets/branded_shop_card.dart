// In branded_shop_card.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/branded_shop_model.dart';

class BrandedShopCard extends StatelessWidget {
  final BrandedShop brandedShop;

  const BrandedShopCard({Key? key, required this.brandedShop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150, // Adjust width as needed
      margin: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: [
            Image.network(
              brandedShop
                  .logo, // Assuming you have an logo in the BrandedShop model
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                brandedShop.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
