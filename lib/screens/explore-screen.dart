import 'package:flutter/material.dart';

import '../utils/colours.dart';
import '../widgets/explore-list-design.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: SearchBar(

                ),
              ),
              SizedBox(
                height: 710,
                  child: ExploreListWidget()
              ),
            ],
          ),
      ),
    );
  }
}


