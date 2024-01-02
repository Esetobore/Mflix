import 'package:circular_progress_stack/circular_progress_stack.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mflix/models/series-model.dart';
import 'package:mflix/widgets/default-carousel.dart';
import 'package:mflix/widgets/series-carousel.dart';
import '../controller/home-screen-controller.dart';
import '../models/cast-model.dart';
import '../models/movie-genre-model.dart';
import '../utils/api-endpoint.dart';
import '../utils/colours.dart';
import '../widgets/cast-list-design.dart';
import '../widgets/custom-buttons-fill.dart';

class SeriesDetailsScreen extends StatefulWidget {
  const SeriesDetailsScreen({
    super.key,
    required this.series,
  });

  final SeriesModel series;

  @override
  State<SeriesDetailsScreen> createState() => _SeriesDetailsScreenState();
}
final HomeScreenController homeScreenController = Get.put(HomeScreenController());
List<MovieGenreModel> movieGenre = [];
List<CastModel> castList = [];

class _SeriesDetailsScreenState extends State<SeriesDetailsScreen> {


  @override
  void initState() {
    super.initState();
    if (movieGenre.isEmpty) {
      homeScreenController.getMovieGenreList().then((genreList) {
        setState(() {
          movieGenre = genreList;
        });
      }).catchError((error) {
          print('Error fetching genre list: $error');
      });
    } else {
        print('Genre list already available.');
    }
  }

  List<String> getGenresNames() {
    if (widget.series.genre.isNotEmpty) {
      return widget.series.genre
          .map((id) {
        final genre = movieGenre.firstWhere(
              (genre) => genre.id == id,
          orElse: () => MovieGenreModel(id: 0, genreName: ' '), // Default value for unknown genre
        );
        return genre.genreName;
      })
          .toList();
    } else {
      return ['Unknown'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 300,
            width: double.infinity,
            child: Stack(
              children: [
                Image.network(
                  '${ApiEndPoints.imagePath}${widget.series.backDropPath}',
                  fit: BoxFit.fill,
                  filterQuality: FilterQuality.high,
                  width: double.infinity,
                  height: 300,
                ),
                Positioned(
                  top: 30,
                  left: 10,
                  child: IconButton(
                    onPressed: () {Get.back();},
                    icon: const Icon(Icons.arrow_back_rounded),
                    color: Colours.palletBlue,
                    iconSize: 30,
                  ),
                ),
              ],
            ),
          ),
          // The rest of your screen content goes here
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 10),
                      child: SizedBox(
                        width: 300,
                        child: Text(
                          widget.series.originalName,
                          style: TextStyle(
                              fontFamily: GoogleFonts.rubik().fontFamily,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colours.palletWhite),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButtonWithText(
                            icon: Icons.play_circle_filled_rounded,
                            text: 'Play',
                            onPressed: (){
                            }),
                        IconButtonWithText(
                            icon: Icons.bookmark_add,
                            text: 'Add to List',
                            onPressed: (){})
                      ],
                    ),
                    const SizedBox(height: 12,),
                    SizedBox(
                      height: 100,
                      child: SingleChildScrollView(
                        child: Text(widget.series.overview,
                          style: TextStyle(
                              fontFamily: GoogleFonts.rubik().fontFamily,
                              fontSize: 17,
                              color: Colours.palletWhite),),
                      ),
                    ),

                    const SizedBox(height: 15,),
                    Row(
                      children: [
                        Text('Aired: ',style: TextStyle(
                            fontFamily: GoogleFonts.rubik().fontFamily,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colours.palletBlue),),
                        Text(widget.series.firstAirDate,style: TextStyle(
                            fontFamily: GoogleFonts.rubik().fontFamily,
                            fontSize: 17,
                            color: Colours.palletWhite),),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        Text('Genre: ',style: TextStyle(
                            fontFamily: GoogleFonts.rubik().fontFamily,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colours.palletRed),),
                        SizedBox(
                          width: 300,
                          child: Text(getGenresNames().join(' '),style: TextStyle(
                              fontFamily: GoogleFonts.rubik().fontFamily,
                              fontSize: 17,
                              color: Colours.palletWhite),),
                        )
                      ],
                    ),
                    const SizedBox(height: 15,),
                    SingleGradientStackCircularProgressBar(
                      size: 50,
                      progressStrokeWidth: 5,
                      backStrokeWidth: 5,
                      startAngle: 0,
                      mergeMode: true,
                      maxValue: 10,
                      backColor: Colours.palletBlack,
                      barColores: const [Colours.palletWhite, Colours.palletBlue, Colours.palletRed],
                      fullProgressColor: Colours.palletRed,
                      barValue: widget.series.voteAverage,
                      textStyle: TextStyle(
                        color: Colours.palletWhite,
                        fontFamily: GoogleFonts.rubik().fontFamily,
                        fontSize: 20,),
                    ),
                    const SizedBox(height: 5,),
                    FutureBuilder(
                      future: homeScreenController.getSeriesCastList(widget.series.id),
                      builder: (context, snapshot){
                        if(snapshot.hasError){
                          return Center(
                            child: Text("CastListBuilder: ${snapshot.error.toString()}"),
                          );
                        }else if(snapshot.hasData){
                          return CastListWidget(snapshot: snapshot);
                        }else{
                          return const SpinKitWave(
                            color: Colours.palletRed,
                            size: 50.0,
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 10,),
                    Text('More like this:',style: TextStyle(
                    fontFamily: GoogleFonts.rubik().fontFamily,
                    fontSize: 17,
                    color: Colours.palletWhite),),
                    FutureBuilder(
                        future: homeScreenController.getSimilarSeries(widget.series.id),
                        builder: (context, snapShot){
                          if(snapShot.hasError){
                            return Text('SimilarSeriesBuilder: ${snapShot.error.toString()}');
                          }else if(snapShot.hasData){
                            return Padding(
                              padding: const EdgeInsets.only(top: 10, bottom: 10),
                              child: SeriesCarouselWidget(snapshot: snapShot),
                            );
                          }else{
                            return const SpinKitWave(
                              color: Colours.palletRed,
                              size: 50.0,
                            );
                          }
                        })
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
