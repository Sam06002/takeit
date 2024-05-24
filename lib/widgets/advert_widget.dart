import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:takeit/utils/app_constants.dart';

class AdvertisementSection extends StatelessWidget {
  final List<String> adImageUrls; // Your list of advertisement image URLs

  const AdvertisementSection({super.key, required this.adImageUrls});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150, // Adjust height as needed
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: adImageUrls.length,
        itemBuilder: (context, index) {
          return _buildAdWidget(adImageUrls[index]);
        },
      ),
    );
  }

  Widget _buildAdWidget(String imageUrl) {
    return TextButton(
      onPressed: () {},
      child: Container(
        margin: const EdgeInsets.all(10), // Spacing between ads
        width: 200, // Adjust ad container width
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.fitWidth,
            )),
      ),
    );
  }
}
