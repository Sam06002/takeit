import 'package:flutter/material.dart';
import 'package:takeit/screens/userPanel/dashboard.dart';
import 'package:takeit/screens/userPanel/main_screen.dart';
import 'package:takeit/test_gmaps.dart';
import 'package:takeit/utils/app_constants.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.appMainColor,
      body: PageView(
        scrollDirection: Axis.horizontal,
        children: const [
          DashBoard(),
          IosGmap(),
        ],
      ),
    );
  }
}
