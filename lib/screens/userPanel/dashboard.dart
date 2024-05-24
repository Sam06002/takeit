import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:latlong2/latlong.dart';
import 'package:takeit/models/shop_loc_model.dart';
import 'package:takeit/screens/userPanel/search_screen.dart';
import 'package:takeit/widgets/banner_widget.dart';
import 'package:takeit/widgets/drawer_widget.dart';
import 'package:takeit/widgets/headings_widget.dart';

import '../../controllers/shop_detail_controller.dart';
import '../../utils/app_constants.dart';
import '../../widgets/map_widget.dart';
import 'cart_screen.dart';
import 'shopDetail_screen.dart';
import 'package:geolocator/geolocator.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

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

  Future<void> _fetchNearbyShops() async {
    try {
      // 1. Load Shops from JSON (You can optimize this by caching the result)
      String shopsJson = await rootBundle.loadString('assets/shoploc.json');
      List<ShopLoc> allShops = (json.decode(shopsJson) as List)
          .map((e) => ShopLoc.fromJson(e))
          .toList();

      // 2. Get User's Location
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      final userLatLng = LatLng(position.latitude, position.longitude);

      // 3. Calculate Distances (Optimized)
      nearbyShops = allShops.where((shop) {
        final distance = const Distance().as(LengthUnit.Kilometer, userLatLng,
            LatLng(shop.latitude, shop.longitude));
        return distance <= 1; // Within 1 km
      }).toList();

      // 4. Fetch Additional Details from Firestore
      for (var shop in nearbyShops) {
        final snapshot = await FirebaseFirestore.instance
            .collection('shops')
            .doc(shop.shopId)
            .get();
        if (snapshot.exists) {
          shop.shopName =
              snapshot.data()?['name'] ?? ''; // Set shop name from Firestore
        }
      }

      setState(() {}); // Update the UI with fetched nearbyShops
    } catch (e) {
      // Handle errors, e.g., location permission denied, Firestore fetch failed
      // ignore: avoid_print
      print("Error fetching nearby shops: $e");
      // You can show a Snackbar or alert dialog to the user
    }
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
                backgroundImage: NetworkImage(userPhoto != null
                    ? userPhoto!
                    : "assets/images/logo1.png")),
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
                  onTap: () {},
                  subTitle: "See all"),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: Get.width / 4,
                          height: Get.height / 11,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppConstants.appSecondaryColor),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: CachedNetworkImage(
                              imageUrl:
                                  "https://cdn-icons-png.flaticon.com/512/7263/7263291.png",
                            ),
                          ),
                        ),
                        Text(
                          "Personal Care",
                          style: GoogleFonts.spaceGrotesk(
                              textStyle: const TextStyle(
                                  color: AppConstants.appMainColor,
                                  fontSize: 12,
                                  //letterSpacing: .5,
                                  fontWeight: FontWeight.w100)),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: Get.width / 4,
                          height: Get.height / 11,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppConstants.appSecondaryColor),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: CachedNetworkImage(
                              imageUrl:
                                  "https://cdn-icons-png.flaticon.com/512/3859/3859737.png",
                            ),
                          ),
                        ),
                        Text(
                          "Food & Drinks",
                          style: GoogleFonts.spaceGrotesk(
                              textStyle: const TextStyle(
                                  color: AppConstants.appMainColor,
                                  fontSize: 12,
                                  //letterSpacing: .5,
                                  fontWeight: FontWeight.w100)),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: Get.width / 4,
                          height: Get.height / 11,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppConstants.appSecondaryColor),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: CachedNetworkImage(
                              imageUrl:
                                  "https://cdn-icons-png.flaticon.com/512/1529/1529570.png",
                            ),
                          ),
                        ),
                        Text(
                          "Medicines",
                          style: GoogleFonts.spaceGrotesk(
                              textStyle: const TextStyle(
                                  color: AppConstants.appMainColor,
                                  fontSize: 12,
                                  //letterSpacing: .5,
                                  fontWeight: FontWeight.w100)),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: Get.width / 4,
                          height: Get.height / 11,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppConstants.appSecondaryColor),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: CachedNetworkImage(
                              imageUrl:
                                  "https://cdn-icons-png.flaticon.com/512/2553/2553629.png",
                            ),
                          ),
                        ),
                        Text(
                          "Household Care",
                          style: GoogleFonts.spaceGrotesk(
                              textStyle: const TextStyle(
                                  color: AppConstants.appMainColor,
                                  fontSize: 12,
                                  //letterSpacing: .5,
                                  fontWeight: FontWeight.w100)),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: Get.width / 4,
                          height: Get.height / 11,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppConstants.appSecondaryColor),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: CachedNetworkImage(
                              imageUrl:
                                  "https://cdn-icons-png.flaticon.com/512/2681/2681662.png",
                            ),
                          ),
                        ),
                        Text(
                          "Pet Supplies",
                          style: GoogleFonts.spaceGrotesk(
                              textStyle: const TextStyle(
                                  color: AppConstants.appMainColor,
                                  fontSize: 12,
                                  //letterSpacing: .5,
                                  fontWeight: FontWeight.w100)),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: Get.width / 4,
                          height: Get.height / 11,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppConstants.appSecondaryColor),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: CachedNetworkImage(
                              imageUrl:
                                  "https://cdn-icons-png.flaticon.com/512/7340/7340650.png",
                            ),
                          ),
                        ),
                        Text(
                          "Stationary",
                          style: GoogleFonts.spaceGrotesk(
                              textStyle: const TextStyle(
                                  color: AppConstants.appMainColor,
                                  fontSize: 12,
                                  //letterSpacing: .5,
                                  fontWeight: FontWeight.w100)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: HeadingWidget(
                  title: "Shops Near You 🏘️",
                  onTap: () {},
                  subTitle: "See all"),
            ),
            FutureBuilder(
              future: _fetchNearbyShops(), // Call your async function here
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: AppConstants.appYellowColor,
                  )); // Show loading
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text('Error: ${snapshot.error}')); // Show error
                } else {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: nearbyShops.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(nearbyShops[index].shopName),
                        // Add other fields or widgets here (e.g., thumbnail)
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShopDetailScreen(
                                  shopId: nearbyShops[index].shopId),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
              },
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
        shadowColor: Colors.black,
        surfaceTintColor: AppConstants.appSecondColor,
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
