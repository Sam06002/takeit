import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: unused_import
import 'package:get/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:takeit/controllers/gsignin_controller.dart';
import 'package:takeit/screens/authUI/signin_screen.dart';
import 'package:takeit/screens/merchantPanel/merchant_signup.dart';

import '../../utils/app_constants.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final GoogleSigninController _googleSigninController =
      Get.put(GoogleSigninController());

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppConstants.appSecondColor,
        title: Text(
          'Take it',
          style: GoogleFonts.spaceGrotesk(
            textStyle: const TextStyle(
                color: AppConstants.appSecondColor,
                fontSize: 25,
                //letterSpacing: .5,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        color: AppConstants.appSecondColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: AppConstants.appSecondColor,
              child: Lottie.asset("assets/images/welcome.json"),
            ),
            const SizedBox(),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text(
                'Join Take it Today',
                style: GoogleFonts.spaceGrotesk(
                  textStyle: const TextStyle(
                      color: AppConstants.appMainColor,
                      fontSize: 25,
                      letterSpacing: .5,
                      fontWeight: FontWeight.w100),
                ),
              ),
            ),

            // ignore: avoid_unnecessary_containers
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: screenSize.height / 10,
                  width: screenSize.width / 4,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppConstants.appSecondaryColor,
                  ),
                  child: IconButton(
                    icon: Image.asset(
                      "assets/images/gooogle.webp",
                      width: screenSize.width / 10,
                      height: screenSize.height / 10,
                    ),
                    onPressed: () {
                      _googleSigninController.siginWithGoogle();
                    },
                  ),
                ),
                SizedBox(
                  width: screenSize.width / 20,
                ),
                Container(
                  height: screenSize.height / 10,
                  width: screenSize.width / 4,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppConstants.appSecondaryColor,
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.email_outlined,
                      color: AppConstants.appMainColor,
                    ),
                    onPressed: () {
                      Get.to(() => const SigninScreen());
                    },
                  ),
                ),
              ],
            ),

            Column(
              children: [
                SizedBox(
                  height: Get.height / 5,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const MerchantsignupScreen());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.account_box,
                        color: AppConstants.appThirdColor,
                      ),
                      Text("  Take it Merchant ",
                          style: GoogleFonts.spaceGrotesk(
                              textStyle: const TextStyle(
                                  color: AppConstants.appThirdColor,
                                  fontSize: 17,
                                  letterSpacing: .5,
                                  fontWeight: FontWeight.w500))),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
