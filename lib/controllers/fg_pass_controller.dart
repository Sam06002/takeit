import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:takeit/utils/app_constants.dart';

class FgPassController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // ignore: unused_field
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ignore: body_might_complete_normally_nullable
  Future<void> fgPassMethod(
    String userEmail,
  ) async {
    try {
      EasyLoading.show(status: "Get ready to Take it");

      await _auth.sendPasswordResetEmail(email: userEmail);
      Get.snackbar("Request Sent ",
          'Check your email $userEmail for the link to reset password',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstants.appSecondaryColor,
          colorText: AppConstants.appThirdColor);

      EasyLoading.dismiss();
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      Get.snackbar("Uhh Ohh , Failed", "$e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstants.appSecondaryColor,
          colorText: AppConstants.appThirdColor);
    }
  }
}
