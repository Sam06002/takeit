import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'package:takeit/controllers/user_type_controller.dart';

import 'package:takeit/screens/authUI/welcome_screen.dart';
import 'package:takeit/screens/merchantPanel/merchant_screen.dart';
import 'package:takeit/screens/userPanel/dashboard.dart';

import 'package:takeit/utils/app_constants.dart';

// ignore: unused_import
import '../userPanel/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  void initstate() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Get.offAll(() => WelcomeScreen());
    });
  }

  Future<void> loggedIn(BuildContext context) async {
    final UserTypeController userTypeController = Get.put(UserTypeController());
    if (user != null) {
      // ignore: unused_local_variable
      var userData = await userTypeController.getUserType(user!.uid);
      if (userData[0]['isShop'] == true) {
        Get.offAll(() => const MerchantScreen());
      } else {
        // ignore: prefer_const_constructors
        Get.offAll(() => const DashBoard());
      }
    } else {
      Get.offAll(() => WelcomeScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      loggedIn(context);
    });
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppConstants.appSecondColor,
        appBar: AppBar(
          backgroundColor: AppConstants.appSecondColor,
          elevation: 0,
        ),
        // ignore: avoid_unnecessary_containers
        body: SizedBox(
          width: screenSize.width,
          height: screenSize.height,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(50),
                  child: Image.asset("assets/images/txtbg.png"),
                  //child: Lottie.asset("assets/images/pay.json", repeat: false),
                ),
              ),
              // ignore: avoid_unnecessary_containers
              Container(
                margin: const EdgeInsets.all(20),
                child: Text(
                  'Powered by Cypherash Labs',
                  style: GoogleFonts.spaceGrotesk(
                    textStyle: const TextStyle(
                        color: AppConstants.appMainColor,
                        fontSize: 13,
                        //letterSpacing: .5,
                        fontWeight: FontWeight.w100),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
