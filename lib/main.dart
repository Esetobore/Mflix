import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mflix/screens/navbar-screen.dart';
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

