import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mflix/controller/home-screen-controller.dart';
import 'package:mflix/screens/explore-screen.dart';
import 'package:mflix/screens/home-screen.dart';
import 'package:mflix/widgets/navbar-screen.dart';
import 'package:mflix/utils/theme.dart';


main() async {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mflix',
      initialRoute: '/navbar',
      theme: lightMode,
      darkTheme: darkMode,
      getPages: [
        GetPage(name: '/navbar', page: () => NavBarScreen()),
      ],
    );
  }
}

