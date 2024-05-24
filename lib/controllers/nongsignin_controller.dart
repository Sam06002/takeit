import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:takeit/utils/app_constants.dart';

class NonGsigninController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // ignore: unused_field
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var isPassVisible = true.obs;

  // ignore: body_might_complete_normally_nullable
  Future<UserCredential?> singInMethod(
    String userEmail,
    String userPass,
  ) async {
    try {
      EasyLoading.show(status: "Get ready to Take it");

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: userEmail, password: userPass);

      EasyLoading.dismiss();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      Get.snackbar("Uhh Ohh , Failed", "$e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstants.appSecondaryColor,
          colorText: AppConstants.appThirdColor);
    }
  }
}
