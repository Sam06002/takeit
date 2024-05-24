// ignore_for_file: unnecessary_import, unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:takeit/controllers/fg_pass_controller.dart';
import 'package:takeit/controllers/nongsignin_controller.dart';
import 'package:takeit/screens/authUI/signin_screen.dart';
import 'package:takeit/widgets/home_widget.dart';

import '../../utils/app_constants.dart';
import 'signup_screen.dart';

class FgpassScreen extends StatefulWidget {
  const FgpassScreen({super.key});

  @override
  State<FgpassScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<FgpassScreen> {
  final FgPassController fgPassController = Get.put(FgPassController());
  TextEditingController userEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppConstants.appMainColor,
          title: Text(
            'Forget Password',
            style: GoogleFonts.spaceGrotesk(
              textStyle: const TextStyle(
                  color: AppConstants.appSecondColor,
                  fontSize: 25,
                  //letterSpacing: .5,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        body: Container(
          width: screenSize.width,
          color: AppConstants.appMainColor,
          child: Column(
            children: [
              isKeyboardVisible
                  ? const SizedBox.shrink()
                  : Column(children: [Image.asset("assets/images/logo.png")]),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: screenSize.width / 1.25,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: userEmail,
                      style: const TextStyle(color: AppConstants.appThirdColor),
                      cursorColor: AppConstants.appSecondColor,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          labelText: "Flash.co Email",
                          labelStyle:
                              TextStyle(color: AppConstants.appSecondColor),
                          prefixIcon: Icon(
                            Icons.email_rounded,
                            color: AppConstants.appSecondColor,
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: screenSize.width / 1.3,
                  height: screenSize.height / 13,
                  decoration: BoxDecoration(
                      color: AppConstants.appSecondColor,
                      borderRadius: BorderRadius.circular(25)),
                  child: TextButton.icon(
                    icon: const Icon(
                      Icons.password,
                      color: AppConstants.appMainColor,
                    ),
                    onPressed: () async {
                      String email = userEmail.text.trim();

                      if (email.isEmpty) {
                        Get.snackbar(
                            "Forgot Password?", "Please enter your email ");
                      } else {
                        String email = userEmail.text.trim();
                        fgPassController.fgPassMethod(email);
                        Get.offAll(() => const SigninScreen());
                      }
                    },
                    label: Text(
                      'Forgot Password',
                      style: GoogleFonts.spaceGrotesk(
                        textStyle: const TextStyle(
                            color: AppConstants.appMainColor,
                            fontSize: 20,
                            //letterSpacing: .5,
                            fontWeight: FontWeight.w200),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
