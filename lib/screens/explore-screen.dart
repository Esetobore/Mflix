import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:mflix/controller/explore-screen-controller.dart';
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
        ? Center(
        child: SpinKitWave(
          color: Theme.of(context).colorScheme.secondary,
          size: 50.0,
        ) )
        : const ExploreScreenBuild());
  }
}
class ExploreScreenBuild extends StatelessWidget {
  const ExploreScreenBuild({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
          child: Column(
            children: [
               Padding(
                padding: const EdgeInsets.all(15.0),
                child: SearchBar(
                  hintText: "Search....",
                  controller: exploreScreenController.searchController,
                  onSubmitted: (String value) {
                    Get.to(() => SearchResultScreen(value: value,));
                  },
                ),
              ),

              const Expanded(child: ExploreListWidget()),
            ],
          ),
      ),
    );
  }
}


