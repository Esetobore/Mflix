import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mflix/utils/get_theme_controller.dart';
import 'package:mflix/screens/navbar-screen.dart';
import 'package:mflix/utils/theme.dart';


main() async {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeController _themeController = Get.put(ThemeController());
  MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mflix',
      home: NavBarScreen(),
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}

