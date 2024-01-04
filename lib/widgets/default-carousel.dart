import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mflix/screens/movies-details-screen.dart';
import 'package:mflix/utils/api-endpoint.dart';

class CarouselWidget extends StatelessWidget {
   CarouselWidget({
    super.key,
     required this.snapshot
  });

  AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: snapshot.data.length ?? 0,
        options: CarouselOptions(
          height: 200,
          viewportFraction: 0.4,
          autoPlay: false,
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
                height: 200,
                width: 150,
                child: Image.network(
                  '${ApiEndPoints.imagePath}$posterPath',
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                )
              ),
            ),
          );
        }
    );
  }
}