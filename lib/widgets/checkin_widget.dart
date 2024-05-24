// ignore: unused_import

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: unused_import
import 'package:takeit/utils/app_constants.dart';

class CheckinWidget extends StatelessWidget {
  final List<String> adImageUrls;
  final List<IconData> adiconList; // Your list of advertisement image URLs

  const CheckinWidget(
      {super.key, required this.adImageUrls, required this.adiconList});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150, // Adjust height as needed
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: adImageUrls.length,
        itemBuilder: (context, index) {
          return _buildAdWidget(
            adImageUrls[index],
          );
        },
      ),
    );
  }

  Widget _buildAdWidget(
    String imageUrl,
  ) {
    return TextButton(
        onPressed: () {},
        child: Container(
          margin: const EdgeInsets.all(10), // Spacing between ads
          width: 250,
          height: 150, // Adjust ad container width
          decoration: BoxDecoration(
            color: AppConstants.appSecondaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.accessibility_outlined,
                color: Colors.white,
              ),
              Text(
                imageUrl,
                style: GoogleFonts.spaceGrotesk(
                  textStyle: const TextStyle(
                      color: AppConstants.appSecondColor,
                      fontSize: 25,
                      //letterSpacing: .5,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ));
  }
}
