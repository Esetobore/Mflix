import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mflix/widgets/bottom-navbar-widget.dart';
import 'package:mflix/utils/colours.dart';
import 'screens/home-screen.dart';


main() async {
  runApp( GetMaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Mflix',
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Colours.palletBlack,
      useMaterial3: true,
    ),
      home: NavBarScreen(),
  ));
}

