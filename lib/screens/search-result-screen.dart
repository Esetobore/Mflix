import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mflix/screens/series-details-screen.dart';
import '../models/media-model.dart';
import '../utils/api-endpoint.dart';
import '../utils/colours.dart';
import 'explore-screen.dart';
import 'movies-details-screen.dart';

class SearchResultScreen extends StatefulWidget {
  String value;

  SearchResultScreen({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Results'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text("<${widget.value}>", style: TextStyle(
                fontFamily: GoogleFonts.rubik().fontFamily,
                fontSize: 20,
                color: Theme.of(context).colorScheme.primary
            ),),
            const SizedBox(height: 10,),
        FutureBuilder(
          future: exploreScreenController.getSearchResult(widget.value),
          builder: (context, snapshot){
            if(snapshot.hasError){
              return const Text('Something went wrong');
            }
            if(snapshot.hasData){
              return Column(
                children: [
                  CarouselSlider.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      options: CarouselOptions(
                        height: 250,
                        viewportFraction: 0.4,
                        autoPlay: false,
                        scrollDirection: Axis.horizontal,
                      ),
                      itemBuilder: (context, itemIndex, pageViewIndex) {
                        if (snapshot.data != null && itemIndex < snapshot.data!.length) {
                          final MediaModel media = snapshot.data![itemIndex];
                          final posterPath = media.posterPath;
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    String? mediaType = snapshot.data?[itemIndex].mediaType.toString();
                                    if (mediaType?.toLowerCase() == "tv") {
                                      Get.to(() => SeriesDetailsScreen(series: snapshot.data![itemIndex]));
                                    } else if(mediaType?.toLowerCase() == "movie") {
                                      Get.to(() => MoviesDetailsScreen(movies: snapshot.data![itemIndex]));
                                    }
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
                                const SizedBox(height: 10),
                              ],
                            ),
                          );
                        }
                        else {
                          return const Center(child: Text("No Result Found"));
                        }
                      }
                  ),
                ],
              );
            }else{
              return const SpinKitWave(
                color: Colours.palletRed,
                size: 50.0,
              );
            }
          },
        ),
          ],
        ),
      ),
    );
  }
}
