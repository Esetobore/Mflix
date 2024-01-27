import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mflix/controller/navigation-bar-controller.dart';
import 'package:mflix/screens/bookmark-screen.dart';
import 'package:mflix/screens/explore-screen.dart';
import 'package:mflix/screens/home-screen.dart';
import 'package:mflix/screens/more-screen.dart';

import '../utils/colours.dart';

class NavBarScreen extends StatelessWidget {
  final NavigationBarController navigationBarController = Get.put(NavigationBarController());

  final TextStyle unselectedLabelStyle = TextStyle(
      color: Colours.palletWhite,
      fontFamily: GoogleFonts.rubik().fontFamily,
      fontSize: 10);

  final TextStyle selectedLabelStyle = TextStyle(
      color: Colours.palletRed,
      fontFamily: GoogleFonts.rubik().fontFamily,
      fontSize: 10);

  NavBarScreen({super.key});

  buildBottomNavigationMenu(context, landingPageController) {
    return Obx(() => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
        child: SizedBox(
          height: 54,
          child: BottomNavigationBar(
            showUnselectedLabels: true,
            showSelectedLabels: true,
            onTap: navigationBarController.changeTabIndex,
            currentIndex: navigationBarController.tabIndex.value,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Theme.of(context).colorScheme.onSecondary,
            unselectedItemColor: Colours.palletBlue,
            selectedItemColor: Colours.palletRed,
            unselectedLabelStyle: unselectedLabelStyle,
            selectedLabelStyle: selectedLabelStyle,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: 'Home',
                backgroundColor: Colours.palletRed, // Set your color for unselected state
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.explore_rounded),
                label: 'Explore',
                backgroundColor: Colours.palletBlue, // Set your color for unselected state
              ),
              BottomNavigationBarItem(
                icon:  Icon(Icons.collections_bookmark_rounded),
                label: 'My List',
                backgroundColor: Colours.palletBlue, // Set your color for unselected state
              ),
              BottomNavigationBarItem(
                icon:  Icon(Icons.more_horiz_rounded),
                label: 'More',
                backgroundColor: Colours.palletBlue, // Set your color for unselected state
              ),
            ],
          ),
        )));
  }

  @override
  Widget build(BuildContext context) {
    final NavigationBarController navigationBarController =
    Get.put(NavigationBarController(), permanent: false);
    return SafeArea(
        child: Scaffold(
          bottomNavigationBar:
          buildBottomNavigationMenu(context, navigationBarController),
          body: Obx(() => IndexedStack(
            index: navigationBarController.tabIndex.value,
            children: const [
              HomeScreen(),
              ExploreScreen(),
              BookMarkScreen(),
              MoreScreen(),
            ],
          )),
        ));
  }
}