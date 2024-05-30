import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:takeit/utils/app_constants.dart';

class HeadingWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final VoidCallback onTap;
  const HeadingWidget(
      {super.key,
      required this.title,
      required this.onTap,
      required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: GoogleFonts.spaceGrotesk(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    //letterSpacing: .5,
                  ),
                )),
            GestureDetector(
              onTap: onTap,
              child: Text(subTitle,
                  style: GoogleFonts.spaceGrotesk(
                    textStyle: const TextStyle(
                      color: AppConstants.appYellowColor,
                      fontSize: 15,
                      //letterSpacing: .5,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
