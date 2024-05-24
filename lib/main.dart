import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:takeit/screens/authUI/splash_screen.dart';
import 'package:takeit/services/mongo_db.dart';
// ignore: unused_import
import 'package:takeit/test_gmaps.dart';

import 'controllers/cart_controller.dart';
import 'controllers/hotspot_controller.dart';
import 'controllers/nearbyShop_controller.dart';
import 'firebase_options.dart';

//import 'screens/userPanel/main_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await DatabaseService().connect();

  Get.put(CartController());
  Get.put(HotspotController());

  // Establish MongoDB connection before running the app

  // Now, initialize your GetX controllers after DB connection is established

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      builder: EasyLoading.init(),
      //home: IosGmap(),
    );
  }
}
