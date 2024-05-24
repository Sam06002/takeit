import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:takeit/controllers/device_token_controller.dart';
import 'package:takeit/models/user_model.dart';
import 'package:takeit/widgets/home_widget.dart';

class GoogleSigninController extends GetxController {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  // ignore: unused_field
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> siginWithGoogle() async {
    final DeviceTokenController deviceTokenController =
        Get.put(DeviceTokenController());

    try {
      // ignore: unused_local_variable
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        EasyLoading.show(status: "Get Ready to Take it");
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(credential);
        final User? user = userCredential.user;

        if (user != null) {
          UserModel userModel = UserModel(
              uId: user.uid,
              username: user.displayName.toString(),
              email: user.email.toString(),
              phone: user.phoneNumber.toString(),
              userImg: user.photoURL.toString(),
              userDeviceToken: deviceTokenController.deviceToken.toString(),
              country: '',
              userAddress: '',
              street: '',
              isShop: false,
              isActive: true,
              createdOn: DateTime.now(),
              city: '',
              aov: '',
              objId: "");

          FirebaseFirestore.instance
              .collection("users")
              .doc(user.uid)
              .set(userModel.toMap());
          EasyLoading.dismiss();

          Get.offAll(() => const HomeWidget());
        }
      }
    } catch (e) {
      EasyLoading.dismiss(animation: false);
      // ignore: avoid_print
      print("error $e");
    }
  }
}
