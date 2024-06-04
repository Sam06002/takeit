import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_card/image_card.dart';

import 'package:takeit/models/shop_loc_model.dart';
import 'package:takeit/screens/userPanel/allcategories_screen.dart';
import 'package:takeit/screens/userPanel/allflash_sale_screen.dart';
import 'package:takeit/screens/userPanel/search_screen.dart';
import 'package:takeit/widgets/allproducts_widget.dart';
import 'package:takeit/widgets/banner_widget.dart';
import 'package:takeit/widgets/drawer_widget.dart';
import 'package:takeit/widgets/flashSale_widget.dart';
import 'package:takeit/widgets/headings_widget.dart';

import '../../controllers/shop_detail_controller.dart';
import '../../utils/app_constants.dart';
import '../../widgets/categories_widget.dart';
import '../../widgets/map_widget.dart';
import 'allProducts_screen.dart';
import 'cart_screen.dart';
import 'shopDetail_screen.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  List<ShopLoc> nearbyShops = [];
  String? userPhoto;
  String? userName;

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  void _fetchUserDetails() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        setState(() {
          userPhoto = user.photoURL;
          userName = user.displayName;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.appSecondColor,
      appBar: AppBar(
        backgroundColor: AppConstants.appSecondColor,
        elevation: 0,
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: CircleAvatar(
              backgroundImage: userPhoto != null
                  ? NetworkImage(userPhoto!)
                  : const AssetImage("assets/images/txtbg.png")
                      as ImageProvider,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        }),
        centerTitle: false,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome',
                style: GoogleFonts.spaceGrotesk(
                    textStyle: const TextStyle(
                        color: AppConstants.appMainColor,
                        fontSize: 15,
                        //letterSpacing: .5,
                        fontWeight: FontWeight.w500))),
            Text(userName != null ? userName! : 'User',
                style: GoogleFonts.spaceGrotesk(
                    textStyle: const TextStyle(
                        color: AppConstants.appMainColor,
                        fontSize: 15,
                        //letterSpacing: .5,
                        fontWeight: FontWeight.w500))),
          ],
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: AppConstants.appSecondaryColor,
                  borderRadius: BorderRadius.circular(30.0),
                  border: Border.all(
                    color: AppConstants.appSecondaryColor,
                    width: 1.0,
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.edit_location_alt_outlined,
                      color: AppConstants.appYellowColor,
                    ),
                    onPressed: () {},
                  ),
                  const Icon(Icons.keyboard_arrow_down_rounded,
                      color: AppConstants.appYellowColor)
                ],
              ),
            ),
          ),
        ],
      ),
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: GestureDetector(
                onTap: () => Get.to(() => const SearchScreen()),
                child: TextButton(
                  onPressed: () => Get.to(() => const SearchScreen()),
                  // Search bar in the body

                  child: Container(
                    height: Get.height / 15,
                    decoration: const BoxDecoration(
                        color: AppConstants.appSecondaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.search,
                            color: AppConstants.appYellowColor,
                          ),
                          Text(
                            "Search Shops",
                            style: TextStyle(
                              color: Colors.grey[500],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const BannerWidget(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: HeadingWidget(
                  title: "Daily Essentials 🧺",
                  onTap: () => Get.to(() => const AllCategoriesScreen()),
                  subTitle: "See all"),
            ),
            const CategoriesWidget(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: HeadingWidget(
                  title: "Shops  💰",
                  onTap: () => Get.to(() => const AllFlashSaleScreen()),
                  subTitle: "See all"),
            ),
            GestureDetector(
              onTap: () {
                Get.put(ShopDetailController(
                    shopId:
                        "C4iO9SKkFsFnViEo8YIi")); // Put the controller before navigating
                Get.to(() => const ShopDetailScreen(
                      shopId: "C4iO9SKkFsFnViEo8YIi",
                    ));
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: FillImageCard(
                  width: Get.width,
                  heightImage: 140,
                  imageProvider: const NetworkImage(
                      "https://www.24-seven.in/img/screen7-3.png"),
                  tags: [const Text("Groceries")],
                  title: const Text("Kia's Heaven 247"),
                  description: const Text("Bahadurgarh HR"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: FillImageCard(
                width: Get.width,
                heightImage: 140,
                imageProvider: const NetworkImage(
                    "https://lh3.googleusercontent.com/p/AF1QipPrhrk0zmT67VWzIYIn0R6g2wxmrgThukAxiRf1=s1360-w1360-h1020"),
                tags: [const Text("Fruits & Shakes")],
                title: const Text("Balaji Shake Wala"),
                description: const Text("Bahadurgarh HR"),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: AppConstants.appYellowColor,
          foregroundColor: AppConstants.appMainColor,
          onPressed: () {
            showModalBottomSheet(
                backgroundColor: AppConstants.appSecondColor,
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
        clipBehavior: Clip.antiAlias,
        shadowColor: Colors.black,
        surfaceTintColor: AppConstants.appSecondaryColor,
        elevation: 10,
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
                    color: Colors.grey,
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
                    color: Colors.grey,
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
                    color: Colors.grey,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.account_box_rounded,
                    color: Colors.grey,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
