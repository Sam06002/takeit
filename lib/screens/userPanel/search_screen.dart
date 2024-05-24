import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_constants.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.appSecondColor,
      appBar: AppBar(
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back, color: AppConstants.appYellowColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Shops 🏘️",
          style: GoogleFonts.spaceGrotesk(
              textStyle: const TextStyle(
                  color: AppConstants.appYellowColor,
                  fontSize: 25,
                  //letterSpacing: .5,
                  fontWeight: FontWeight.w500)),
        ),
        backgroundColor: AppConstants.appSecondColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: TextField(
              autofocus: true,
              // Search bar in the body

              keyboardType: TextInputType.text,

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
                hintStyle: TextStyle(
                  color: Colors.grey[500],
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppConstants.appYellowColor,
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: AppConstants.appSecondaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
