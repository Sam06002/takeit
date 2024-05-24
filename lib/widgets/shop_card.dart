import 'package:flutter/material.dart';
import 'package:takeit/models/branded_shop_model.dart';
import '../models/shop_model.dart';

class ShopCard extends StatelessWidget {
  final BrandedShop shop;

  const ShopCard({Key? key, required this.shop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150, // Adjust width as needed
      margin: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: [
            Image.network(
              shop.logo, // Assuming you have an imageUrl in the Shop model
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                shop.name,
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
