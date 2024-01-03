import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mflix/controller/explore-screen-controller.dart';
import 'package:mflix/controller/home-screen-controller.dart';
import 'package:mflix/screens/search-result-screen.dart';

import '../utils/colours.dart';
import '../widgets/explore-list-design.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

final ExploreScreenController exploreScreenController = Get.put(ExploreScreenController());

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return  Obx(() => exploreScreenController.isLoading.value
        ? const Center(
        child: SpinKitWave(
          color: Colours.palletRed,
          size: 50.0,
        ) )
        : const exploreScreen());
  }
}
class exploreScreen extends StatelessWidget {
  const exploreScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              ///TODO: Solution to the search bar implement the future builder then
              /// call the searchbar inside the snapshot.hasdata instance
              /// Check Notes for further information
               Padding(
                padding: EdgeInsets.all(15.0),
                child: SearchBar(
                  controller: exploreScreenController.searchController,
                  hintText: "Search......",
                ),
              ),

              Expanded(child: ExploreListWidget()),
            ],
          ),
      ),
    );
  }
}


