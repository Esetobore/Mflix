

import 'package:flutter/material.dart';

import 'colours.dart';

ThemeData lightMode = ThemeData(
  colorScheme: const ColorScheme.light(
    background: Colours.palletWhite,
    primary: Colours.palletBlack,
    secondary: Colours.palletBlue,
    onSecondary: Colours.palletWhite,
  ),
  useMaterial3: true,
);

ThemeData darkMode = ThemeData(
  colorScheme: const ColorScheme.dark(
    background: Colours.palletBlack,
    primary: Colours.palletWhite,
    secondary: Colours.palletRed,
    onSecondary: Colours.palletBlack,
  ),
  useMaterial3: true,
);