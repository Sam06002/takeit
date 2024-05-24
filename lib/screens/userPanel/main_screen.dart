// ignore: file_names

// ignore_for_file: unnecessary_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
// ignore: unused_import
import 'package:google_fonts/google_fonts.dart';

import 'package:takeit/screens/userPanel/cart_screen.dart';
import 'package:takeit/screens/userPanel/shopDetail_screen.dart';
import 'package:takeit/widgets/banner_widget.dart';
import 'package:takeit/widgets/categories_widget.dart';
import 'package:takeit/widgets/drawer_widget.dart';
import 'package:takeit/widgets/headings_widget.dart';
import 'package:takeit/widgets/map_widget.dart';

import '../../controllers/brandedShop_controller.dart';
import '../../controllers/nearbyShop_controller.dart';
import '../../controllers/shop_detail_controller.dart';
import '../../utils/app_constants.dart';
import '../../widgets/branded_shop_card.dart';
import 'brandedShopSetail_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ShopController shopController = Get.put(ShopController());
  String? userName;
  @override
  void initState() {
    super.initState();
    _fetchUserName();
    Get.put(ShopController());
  }

  void _fetchUserName() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        setState(() {
          userName = user.displayName;
        });
      }
    });
  }

  final BrandedShopController brandedShopController =
      Get.put(BrandedShopController());

  @override
  Widget build(BuildContext context) {
    final ShopController shopController = Get.find();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppConstants.appMainColor,
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: AppConstants.appSecondColor,
              statusBarIconBrightness: Brightness.light),
          backgroundColor: AppConstants.appSecondColor,
          shadowColor: AppConstants.appSecondColor,
          elevation: 10,
          title: Text(userName != null ? "Hi, $userName!" : "Loading...",
              style: GoogleFonts.spaceGrotesk(
                  textStyle: const TextStyle(
                      color: AppConstants.appMainColor,
                      fontSize: 20,
                      //letterSpacing: .5,
                      fontWeight: FontWeight.w500))),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.search,
                color: AppConstants.appMainColor,
              ),
              onPressed: () {
                // do something
              },
            )
          ],
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: AppConstants.appMainColor,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
        ),
        //drawer: const DrawerWidget(),
        // ignore: avoid_unnecessary_containers
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: BannerWidget(),
              ),
              HeadingWidget(
                  title: 'Frachises on Take it', subTitle: ' ', onTap: () {}),
              const BannerWidget(),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(5.0),
          child: FloatingActionButton(
            shape: const CircleBorder(),
            backgroundColor: AppConstants.appSecondColor,
            foregroundColor: AppConstants.appMainColor,
            onPressed: () {
              showModalBottomSheet(
                  backgroundColor: Colors.black,
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      decoration: const BoxDecoration(
                          color: AppConstants.appSecondColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25))),
                      height: Get.height / 2,
                      child: const MapWidget(),
                    );
                  });
            },
            child: const Icon(Icons.location_on_rounded),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 10,
          shadowColor: AppConstants.appSecondColor,
          notchMargin: 5.0,
          shape: const CircularNotchedRectangle(),
          color: AppConstants.appSecondColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.home_filled,
                      color: Colors.white,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: IconButton(
                    onPressed: () {
                      Get.put(ShopDetailController(
                          shopId:
                              "C4iO9SKkFsFnViEo8YIi")); // Put the controller before navigating
                      Get.to(() => const ShopDetailScreen(
                            shopId: "C4iO9SKkFsFnViEo8YIi",
                          ));
                    },
                    icon: const Icon(
                      Icons.category,
                      color: Colors.white,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                          backgroundColor: Colors.black,
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              decoration: const BoxDecoration(
                                  color: AppConstants.appSecondColor,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25),
                                      topRight: Radius.circular(25))),
                              height: Get.height / 2,
                              child: const CartScreen(),
                            );
                          });
                    },
                    icon: const Icon(
                      Icons.shopping_cart_checkout,
                      color: Colors.white,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.account_box_rounded,
                      color: Colors.white,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
