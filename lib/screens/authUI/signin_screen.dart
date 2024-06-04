// ignore_for_file: unnecessary_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:takeit/controllers/merchant_type_controller.dart';
import 'package:takeit/controllers/nongsignin_controller.dart';
import 'package:takeit/controllers/user_type_controller.dart';
import 'package:takeit/screens/authUI/fg_pass_screen.dart';
import 'package:takeit/screens/merchantPanel/merchant_screen.dart';
import 'package:takeit/widgets/home_widget.dart';

import '../../utils/app_constants.dart';
import 'signup_screen.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final MerchantTypeController merchantTypeController =
      Get.put(MerchantTypeController());
  final UserTypeController userTypeController = Get.put(UserTypeController());
  final NonGsigninController nonGsigninController =
      Get.put(NonGsigninController());
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppConstants.appMainColor,
          title: Text(
            'Sign In',
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
                  : Column(children: [Image.asset("assets/images/txtbg.png")]),
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
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: screenSize.width / 1.25,
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Obx(
                        () => TextFormField(
                          controller: userPass,
                          obscureText: nonGsigninController.isPassVisible.value,
                          style: const TextStyle(
                              color: AppConstants.appThirdColor),
                          cursorColor: AppConstants.appSecondColor,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: const TextStyle(
                                  color: AppConstants.appSecondColor),
                              prefixIcon: const Icon(
                                Icons.password_rounded,
                                color: AppConstants.appSecondColor,
                              ),
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    nonGsigninController.isPassVisible.toggle();
                                  },
                                  child: nonGsigninController
                                          .isPassVisible.value
                                      ? const Icon(
                                          Icons.visibility_off_rounded,
                                          color: AppConstants.appSecondColor,
                                        )
                                      : const Icon(
                                          Icons.visibility,
                                          color: AppConstants.appSecondColor,
                                        )),
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                        ),
                      ))),
              Padding(
                padding: const EdgeInsets.only(right: 50),
                child: Container(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Get.off(() => const FgpassScreen());
                    },
                    child: Text(
                      'Forgot Password ?',
                      style: GoogleFonts.spaceGrotesk(
                        textStyle: const TextStyle(
                            color: Color.fromARGB(254, 227, 126, 54),
                            fontSize: 15,
                            //letterSpacing: .5,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: screenSize.width / 1.3,
                  height: screenSize.height / 13,
                  decoration: BoxDecoration(
                      color: AppConstants.appSecondColor,
                      borderRadius: BorderRadius.circular(25)),
                  child: TextButton.icon(
                    icon: Image.asset(
                      "assets/images/flash.png",
                      width: screenSize.width / 10,
                      height: screenSize.height / 10,
                    ),
                    onPressed: () async {
                      String email = userEmail.text.trim();
                      String password = userPass.text.trim();

                      if (email.isEmpty || password.isEmpty) {
                        Get.snackbar(
                            "Trying to login?", "Enter all the details first.");
                      } else {
                        UserCredential? userCredential =
                            await nonGsigninController.singInMethod(
                                email, password);

                        var userData = await userTypeController
                            .getUserType(userCredential!.user!.uid);
                        // ignore: unnecessary_null_comparison
                        if (userCredential != null) {
                          if (userCredential.user!.emailVerified) {
                            if (userData[0]['isShop'] == true) {
                              Get.offAll(() => const MerchantScreen());
                              Get.snackbar("Merchant Login Success",
                                  "Get ready to Take it.",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor:
                                      AppConstants.appSecondaryColor,
                                  colorText: AppConstants.appThirdColor);
                            } else {
                              Get.offAll(() => const HomeWidget());
                              Get.snackbar(
                                  "Login Success", "Get ready to Take it.",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor:
                                      AppConstants.appSecondaryColor,
                                  colorText: Colors.white);
                            }
                          } else {
                            Get.snackbar("Email not verified",
                                "Check your email and click on the verification link.",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppConstants.appSecondaryColor,
                                colorText: Colors.white);
                          }
                        } else {
                          Get.snackbar("Issue:", "Please try again",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppConstants.appSecondaryColor,
                              colorText: Colors.white);
                        }
                      }
                    },
                    label: Text(
                      'Sign in with Email',
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.offAll(() => const SignupScreen());
                      },
                      child: Text('Dont have an account ? ',
                          style: GoogleFonts.spaceGrotesk(
                            textStyle: const TextStyle(
                                color: AppConstants.appThirdColor,
                                fontSize: 15,
                                letterSpacing: .5,
                                fontWeight: FontWeight.w200),
                          )),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.to(() => const SignupScreen());
                        },
                        child: Text(
                          'Sign Up',
                          style: GoogleFonts.spaceGrotesk(
                            textStyle: const TextStyle(
                                color: AppConstants.appSecondColor,
                                fontSize: 15,
                                //letterSpacing: .5,
                                fontWeight: FontWeight.w900),
                          ),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
