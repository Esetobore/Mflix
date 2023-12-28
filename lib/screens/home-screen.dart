import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mflix/utils/colours.dart';

import '../controller/navigationbarcontroller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/profile.jpg'),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text('Welcome!', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: GoogleFonts.rubik().fontFamily,
                              fontSize: 17,
                              color: Colours.palletWhite
                          ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text('Movie Magic Awaits', style: TextStyle(
                              fontFamily: GoogleFonts.rubik().fontFamily,
                              fontSize: 13,
                              color: Colours.palletWhite
                          ),),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              CarouselSlider.builder(
                  itemCount: 10,
                  options: CarouselOptions(
                    height: 300,
                    aspectRatio: 16/9,
                    viewportFraction: 0.53,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(seconds: 1),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    scrollDirection: Axis.horizontal,
                  ),
                  itemBuilder: (context, itemIndex, pageViewIndex) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        height: 300,
                        width: 200,
                        color: Colours.palletRed,
                      ),
                    );
                  }
              ),

              //Trending Movies Carousel
              const SizedBox(height: 20,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Trending Movies', style: TextStyle(
                      fontFamily: GoogleFonts.rubik().fontFamily,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colours.palletWhite
                  ),),
                  Text('See all', style: TextStyle(
                      fontFamily: GoogleFonts.rubik().fontFamily,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colours.palletBlue
                  ),),
                ],
              ),
              const SizedBox(height: 10,),
              CarouselSlider.builder(
                  itemCount: 10,
                  options: CarouselOptions(
                    height: 200,
                    viewportFraction: 0.4,
                    autoPlay: false,
                    scrollDirection: Axis.horizontal,
                  ),
                  itemBuilder: (context, itemIndex, pageViewIndex) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        height: 200,
                        width: 150,
                        color: Colours.palletRed,
                      ),
                    );
                  }
              ),

              //Latest Moves Carousel
              const SizedBox(height: 20,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Upcoming Movies', style: TextStyle(
                      fontFamily: GoogleFonts.rubik().fontFamily,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colours.palletWhite
                  ),),
                  Text('See all', style: TextStyle(
                      fontFamily: GoogleFonts.rubik().fontFamily,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colours.palletBlue
                  ),),
                ],
              ),
              const SizedBox(height: 10,),
              CarouselSlider.builder(
                  itemCount: 10,
                  options: CarouselOptions(
                    height: 200,
                    viewportFraction: 0.4,
                    autoPlay: false,
                    scrollDirection: Axis.horizontal,
                  ),
                  itemBuilder: (context, itemIndex, pageViewIndex) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        height: 200,
                        width: 150,
                        color: Colours.palletRed,
                      ),
                    );
                  }
              ),

              //Latest Series Carousel
              const SizedBox(height: 20,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Latest Series', style: TextStyle(
                      fontFamily: GoogleFonts.rubik().fontFamily,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colours.palletWhite
                  ),),
                  Text('See all', style: TextStyle(
                      fontFamily: GoogleFonts.rubik().fontFamily,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colours.palletBlue
                  ),),
                ],
              ),
              const SizedBox(height: 10,),
              CarouselSlider.builder(
                  itemCount: 10,
                  options: CarouselOptions(
                    height: 200,
                    viewportFraction: 0.4,
                    autoPlay: false,
                    scrollDirection: Axis.horizontal,
                  ),
                  itemBuilder: (context, itemIndex, pageViewIndex) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        height: 200,
                        width: 150,
                        color: Colours.palletRed,
                      ),
                    );
                  }
              ),

            ],
          ),
        ),
      ),

    );
  }

}
