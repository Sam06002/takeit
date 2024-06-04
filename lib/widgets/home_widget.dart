import 'package:flutter/material.dart';
import 'package:takeit/screens/userPanel/dashboard.dart';
import 'package:takeit/utils/app_constants.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppConstants.appMainColor,
      body: DashBoard(),
    );
  }
}
