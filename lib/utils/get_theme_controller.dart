import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mflix/utils/theme.dart';

class ThemeController extends GetxController {
  Rx<ThemeData> themeData = Rx(darkMode);

  ThemeData get getTheme => themeData.value;

  void toggleTheme() {
    themeData.value = themeData.value == darkMode ? lightMode : darkMode;
    update();
  }
}
