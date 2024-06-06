import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:takeit/controllers/offer_banner_controller.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final CarouselController carouselController = CarouselController();
  final OfferBannerController _offerBannerController =
      Get.put(OfferBannerController());
  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Obx(() {
        return CarouselSlider(
          items: _offerBannerController.offerBanner
              // ignore: non_constant_identifier_names,
              .map((ImgUrl) => ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: CachedNetworkImage(
                      imageUrl: ImgUrl,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width / 1.1,
                      height: MediaQuery.of(context).size.height / 3,
                      placeholder: (context, url) => const ColoredBox(
                        color: Colors.white,
                        child: CupertinoActivityIndicator(),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error_outline),
                    ),
                  ))
              .toList(),
          options: CarouselOptions(
            scrollPhysics: const AlwaysScrollableScrollPhysics(),
            height: MediaQuery.of(context).size.height / 6,
            autoPlayCurve: Curves.fastOutSlowIn,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayInterval: const Duration(seconds: 3),
            scrollDirection: Axis.horizontal,
            initialPage: 0,
            enableInfiniteScroll: true,
            autoPlay: true,
            viewportFraction: 1,
          ),
        );
      }),
    );
  }
}
