import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:takeit/utils/app_constants.dart';

class DeviceTokenController extends GetxController {
  String? deviceToken;

  @override
  void onInit() {
    super.onInit();
    getDeviceToken();
  }

  Future<void> getDeviceToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();

      if (token != null) {
        deviceToken = token;
        update();
      }
    } catch (e) {
      Get.snackbar("Error", "$e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstants.appSecondaryColor,
          colorText: AppConstants.appThirdColor);
    }
  }
}