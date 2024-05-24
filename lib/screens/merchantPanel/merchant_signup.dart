import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:takeit/screens/authUI/signin_screen.dart';

import '../../controllers/merchants_signup_controller.dart';
import '../../utils/app_constants.dart';

class MerchantsignupScreen extends StatefulWidget {
  const MerchantsignupScreen({super.key});

  @override
  State<MerchantsignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<MerchantsignupScreen> {
  final MerchantsignUpController signUpController =
      Get.put(MerchantsignUpController());
  TextEditingController userName = TextEditingController();
  TextEditingController userPass = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPhone = TextEditingController();
  TextEditingController userCity = TextEditingController();
  TextEditingController userAOV = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppConstants.appMainColor,
          title: Text(
            'Sign Up for Take it Shop',
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
          height: screenSize.height,
          color: AppConstants.appMainColor,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Container(
              width: screenSize.width,
              color: AppConstants.appMainColor,
              child: Column(
                children: [
                  isKeyboardVisible
                      ? Text(
                          'Merchant details',
                          style: GoogleFonts.spaceGrotesk(
                            textStyle: const TextStyle(
                                color: AppConstants.appSecondColor,
                                fontSize: 25,
                                //letterSpacing: .5,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      : Column(children: [
                          SizedBox(
                            height: screenSize.height / 3,
                            child: Image.asset(
                              "assets/images/logo.png",
                            ),
                          )
                        ]),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      width: screenSize.width / 1.25,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          style: const TextStyle(
                              color: AppConstants.appThirdColor),
                          controller: userName,
                          cursorColor: AppConstants.appSecondColor,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                              labelText: "Shop Name",
                              labelStyle:
                                  TextStyle(color: AppConstants.appSecondColor),
                              prefixIcon: Icon(
                                Icons.person_2_rounded,
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
                        child: TextFormField(
                          style: const TextStyle(
                              color: AppConstants.appThirdColor),
                          controller: userCity,
                          cursorColor: AppConstants.appSecondColor,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                              labelText: "Pincode",
                              labelStyle:
                                  TextStyle(color: AppConstants.appSecondColor),
                              prefixIcon: Icon(
                                Icons.location_on,
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
                        child: TextFormField(
                          style: const TextStyle(
                              color: AppConstants.appThirdColor),
                          controller: userAOV,
                          cursorColor: AppConstants.appSecondColor,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                              labelText: "Average Order Value",
                              labelStyle:
                                  TextStyle(color: AppConstants.appSecondColor),
                              prefixIcon: Icon(
                                Icons.shopping_basket,
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
                        child: TextFormField(
                          style: const TextStyle(
                              color: AppConstants.appThirdColor),
                          controller: userPhone,
                          cursorColor: AppConstants.appSecondColor,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                              labelText: "Phone Number",
                              labelStyle:
                                  TextStyle(color: AppConstants.appSecondColor),
                              prefixIcon: Icon(
                                Icons.phone,
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
                        child: TextFormField(
                          style: const TextStyle(
                              color: AppConstants.appThirdColor),
                          controller: userEmail,
                          cursorColor: AppConstants.appSecondColor,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              labelText: "Owner's Email",
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
                              style: const TextStyle(
                                  color: AppConstants.appThirdColor),
                              controller: userPass,
                              obscureText: signUpController.isPassVisible.value,
                              cursorColor: AppConstants.appSecondColor,
                              keyboardType: TextInputType.visiblePassword,
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
                                        signUpController.isPassVisible.toggle();
                                      },
                                      child: signUpController
                                              .isPassVisible.value
                                          ? const Icon(
                                              Icons.visibility_off_rounded,
                                              color:
                                                  AppConstants.appSecondColor,
                                            )
                                          : const Icon(
                                              Icons.visibility,
                                              color:
                                                  AppConstants.appSecondColor,
                                            )),
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)))),
                            ),
                          ))),
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
                          Icons.manage_accounts,
                          color: AppConstants.appMainColor,
                        ),
                        onPressed: () async {
                          String name = userName.text.trim();
                          String phone = userPhone.text.trim();
                          String email = userEmail.text.trim();
                          String pass = userPass.text.trim();
                          String city = userCity.text.trim();
                          String aov = userAOV.text.trim();
                          String deviceToken = '';

                          if (name.isEmpty ||
                              email.isEmpty ||
                              phone.isEmpty ||
                              pass.isEmpty ||
                              city.isEmpty ||
                              aov.isEmpty) {
                            Get.snackbar("Incomplete Details",
                                "Try again after entering all details.",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppConstants.appSecondaryColor,
                                colorText: AppConstants.appThirdColor);
                          } else {
                            UserCredential? userCredential =
                                await signUpController.singUpMethod(name, phone,
                                    email, pass, deviceToken, city, aov);

                            if (userCredential != null) {
                              Get.snackbar("Email Sent",
                                  "Please check your email to complete the verification",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor:
                                      AppConstants.appSecondaryColor,
                                  colorText: AppConstants.appThirdColor);

                              FirebaseAuth.instance.signOut();
                              Get.offAll(() => const SigninScreen());
                            }
                          }
                        },
                        label: Text(
                          'Take it Shop ',
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
                        Text('Already Have an Account ? ',
                            style: GoogleFonts.spaceGrotesk(
                              textStyle: const TextStyle(
                                  color: AppConstants.appThirdColor,
                                  fontSize: 15,
                                  letterSpacing: .5,
                                  fontWeight: FontWeight.w200),
                            )),
                        Text('Sign In',
                            style: GoogleFonts.spaceGrotesk(
                              textStyle: const TextStyle(
                                  color: AppConstants.appSecondColor,
                                  fontSize: 15,
                                  //letterSpacing: .5,
                                  fontWeight: FontWeight.w900),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
