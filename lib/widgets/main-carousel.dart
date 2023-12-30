import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mflix/screens/movies-details-screen.dart';
import '../utils/api-endpoint.dart';

class MainCarousel extends StatelessWidget {
   const MainCarousel({
    super.key,
    required this.snapshot,
  });

  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: snapshot.data.length ?? 0, // Adjusted to the length of the data
      options: CarouselOptions(
        height: 300,
        aspectRatio: 16 / 9,
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
        final posterPath = snapshot.data?[itemIndex]?.posterPath;
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: GestureDetector(
            onTap: (){
              Get.to(() => MoviesDetailsScreen(movies: snapshot.data[itemIndex]));
            },
            child: SizedBox(
              height: 300,
              width: 200,
              child: Image.network(
                filterQuality: FilterQuality.high,
                fit: BoxFit.cover,
                '${ApiEndPoints.imagePath}$posterPath',
              ),
            ),
          ),
        );
      },

    );
  }
}
