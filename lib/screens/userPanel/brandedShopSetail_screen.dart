import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../controllers/nearbyShop_controller.dart';
import '../../models/branded_shop_model.dart';
import '../../models/outlet_model.dart';
import '../../widgets/outlet_card.dart';
import 'shopDetail_screen.dart';
// Import your ShopDetailScreen

class BrandShopDetailScreen extends StatelessWidget {
  final BrandedShop brandedShop;

  const BrandShopDetailScreen({super.key, required this.brandedShop});

  @override
  Widget build(BuildContext context) {
    final ShopController shopController = Get.find<ShopController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(brandedShop.name),
      ),
      body: Obx(() {
        if (shopController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (shopController.outlets.isEmpty) {
          return const Center(child: Text('No outlets found for this brand'));
        } else {
          return _buildOutletList(shopController.outlets);
        }
      }),
    );
  }

  // Function to build the list of outlets
  Widget _buildOutletList(List<Outlet> outlets) {
    return ListView.builder(
      itemCount: outlets.length,
      itemBuilder: (context, index) {
        final outlet = outlets[index];
        return GestureDetector(
          onTap: () {},
          child: OutletCard(outlet: outlet), // Use your OutletCard widget
        );
      },
    );
  }
}
