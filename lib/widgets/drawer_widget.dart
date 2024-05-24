import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:takeit/utils/app_constants.dart';

import '../screens/authUI/welcome_screen.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 150),
        child: Drawer(
          backgroundColor: AppConstants.appSecondColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
          ),
          child: Wrap(
            runSpacing: 10,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                child: ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text(
                    "Takeit.today",
                    style: GoogleFonts.spaceGrotesk(
                      textStyle: const TextStyle(
                          color: AppConstants.appMainColor,
                          fontSize: 18,
                          //letterSpacing: .5,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  subtitle: Text(
                    "Version 1.0.1",
                    style: GoogleFonts.spaceGrotesk(
                      textStyle: const TextStyle(
                          color: AppConstants.appMainColor,
                          fontSize: 12,
                          //letterSpacing: .5,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  leading: const CircleAvatar(
                    radius: 25,
                    backgroundColor: AppConstants.appThirdColor,
                    child: Text("T"),
                  ),
                ),
              ),
              const Divider(
                indent: 10,
                endIndent: 10,
                color: AppConstants.appMainColor,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: ListTile(
                        titleAlignment: ListTileTitleAlignment.center,
                        title: Text(
                          "Home",
                          style: GoogleFonts.spaceGrotesk(
                            textStyle: const TextStyle(
                                color: AppConstants.appMainColor,
                                fontSize: 18,
                                //letterSpacing: .5,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        leading: const Icon(
                          Icons.home_rounded,
                          color: AppConstants.appThirdColor,
                        ),
                        trailing: const Icon(
                          Icons.arrow_circle_right,
                          color: AppConstants.appMainColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: ListTile(
                        titleAlignment: ListTileTitleAlignment.center,
                        title: Text(
                          "Products",
                          style: GoogleFonts.spaceGrotesk(
                            textStyle: const TextStyle(
                                color: AppConstants.appMainColor,
                                fontSize: 18,
                                //letterSpacing: .5,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        leading: const Icon(
                          Icons.category_rounded,
                          color: AppConstants.appThirdColor,
                        ),
                        trailing: const Icon(
                          Icons.arrow_circle_right,
                          color: AppConstants.appMainColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: ListTile(
                        titleAlignment: ListTileTitleAlignment.center,
                        title: Text(
                          "Order History",
                          style: GoogleFonts.spaceGrotesk(
                            textStyle: const TextStyle(
                                color: AppConstants.appMainColor,
                                fontSize: 18,
                                //letterSpacing: .5,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        leading: const Icon(
                          Icons.shopping_bag_rounded,
                          color: AppConstants.appThirdColor,
                        ),
                        trailing: const Icon(
                          Icons.arrow_circle_right,
                          color: AppConstants.appMainColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: ListTile(
                        titleAlignment: ListTileTitleAlignment.center,
                        title: Text(
                          "Cart",
                          style: GoogleFonts.spaceGrotesk(
                            textStyle: const TextStyle(
                                color: AppConstants.appMainColor,
                                fontSize: 18,
                                //letterSpacing: .5,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        leading: const Icon(
                          Icons.shopping_cart_checkout,
                          color: AppConstants.appThirdColor,
                        ),
                        trailing: const Icon(
                          Icons.arrow_circle_right,
                          color: AppConstants.appMainColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: ListTile(
                        titleAlignment: ListTileTitleAlignment.center,
                        title: Text(
                          "Profile",
                          style: GoogleFonts.spaceGrotesk(
                            textStyle: const TextStyle(
                                color: AppConstants.appMainColor,
                                fontSize: 18,
                                //letterSpacing: .5,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        leading: const Icon(
                          Icons.account_box,
                          color: AppConstants.appThirdColor,
                        ),
                        trailing: const Icon(
                          Icons.arrow_circle_right,
                          color: AppConstants.appMainColor,
                        ),
                      ),
                    ),
                    const SizedBox(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: ListTile(
                        titleAlignment: ListTileTitleAlignment.center,
                        title: GestureDetector(
                          onTap: () async {
                            GoogleSignIn googleSignIn = GoogleSignIn();
                            // ignore: no_leading_underscores_for_local_identifiers
                            FirebaseAuth _auth = FirebaseAuth.instance;
                            await _auth.signOut();
                            await googleSignIn.signOut();
                            Get.offAll(() => WelcomeScreen());
                          },
                          child: Text(
                            "Logout",
                            style: GoogleFonts.spaceGrotesk(
                              textStyle: const TextStyle(
                                  color: AppConstants.appMainColor,
                                  fontSize: 18,
                                  //letterSpacing: .5,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        leading: GestureDetector(
                          onTap: () async {
                            GoogleSignIn googleSignIn = GoogleSignIn();
                            // ignore: no_leading_underscores_for_local_identifiers
                            FirebaseAuth _auth = FirebaseAuth.instance;
                            await _auth.signOut();
                            await googleSignIn.signOut();
                            Get.offAll(() => WelcomeScreen());
                          },
                          child: const Icon(
                            Icons.logout_rounded,
                            color: AppConstants.appThirdColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
