import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:takeit/models/user_model.dart';
import 'package:takeit/utils/app_constants.dart';

class MerchantsignUpController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var isPassVisible = true.obs;

  // ignore: body_might_complete_normally_nullable
  Future<UserCredential?> singUpMethod(
    String userName,
    String userPhone,
    String userEmail,
    String userPass,
    String userDeviceToken,
    String userCity,
    String userAOV,
  ) async {
    try {
      EasyLoading.show(status: "Get ready to Take it");

      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: userEmail, password: userPass);

      await userCredential.user!.sendEmailVerification();

      UserModel userModel = UserModel(
          uId: userCredential.user!.uid,
          username: userName,
          email: userEmail,
          phone: userPhone,
          userImg: "",
          userDeviceToken: userDeviceToken,
          country: "",
          userAddress: "",
          street: "",
          isShop: true,
          isActive: true,
          createdOn: DateTime.now(),
          city: userCity,
          aov: userAOV,
          objId: "");

      _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(userModel.toMap());

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
