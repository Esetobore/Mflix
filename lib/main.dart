import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mflix/utils/dotenv.dart';
import 'package:mflix/widgets/navbar-screen.dart';
import 'package:mflix/utils/theme.dart';


Future<void> main() async {
  Dotenv.load();
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
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

