import 'package:circular_progress_stack/circular_progress_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mflix/controller/home-screen-controller.dart';
import 'package:mflix/models/media-model.dart';
import 'package:mflix/utils/api-endpoint.dart';
import 'package:mflix/utils/colours.dart';
import 'package:mflix/widgets/cast-list-design.dart';
import 'package:mflix/widgets/custom-buttons-fill.dart';
import 'package:mflix/widgets/default-carousel.dart';
import '../controller/bookmark-screen-controller.dart';
import '../models/cast-model.dart';
import '../models/movie-genre-model.dart';
import 'package:http/http.dart' as http;

class MoviesDetailsScreen extends StatefulWidget {

  const MoviesDetailsScreen({
    super.key,
    required this.movies,
  });

  final MediaModel movies;


  @override
  State<MoviesDetailsScreen> createState() => _MoviesDetailsScreenState();
}
final HomeScreenController homeScreenController = Get.find();
List<MediaGenreModel> movieGenre = [];
late final List<CastModel> castList;


class _MoviesDetailsScreenState extends State<MoviesDetailsScreen> {
  List<Map<String, dynamic>> moviesList = [];

  @override
  void initState() {
    super.initState();
    if (movieGenre.isEmpty) {
      homeScreenController.getMediaGenreList(http.Client()).then((genreList) {
        setState(() {
          movieGenre = genreList;
        });
      }).catchError((error) {
        throw ('Error fetching genre list: $error');
      });
    }
  }
  List getGenresNames() {
    if (widget.movies.genre.isNotEmpty) {
      return widget.movies.genre
          .map((id) {
        final genre = movieGenre.firstWhere(
              (genre) => genre.id == id,
          orElse: () => MediaGenreModel(id: 0, genreName: ' '), // Default value for unknown genre
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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          SizedBox(
            height: 300,
            width: double.infinity,
            child: Stack(
              children: [
                Image.network(
                  '${ApiEndPoints.imagePath}${widget.movies.backDropPath}',
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
                          widget.movies.title,
                          style: TextStyle(
                              fontFamily: GoogleFonts.rubik().fontFamily,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Theme.of(context).colorScheme.primary),
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
                            onPressed: () {
                              bookmarkController.saveToDatabase(widget.movies.title, widget.movies.posterPath);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Added to List'), duration: Duration(milliseconds: 100),),
                              );
                            },
                        )
                      ],
                    ),
                    const SizedBox(height: 12,),
                    SizedBox(
                      height: 130,
                      child: SingleChildScrollView(
                        child: Text(widget.movies.overview,
                          style: TextStyle(
                              fontFamily: GoogleFonts.rubik().fontFamily,
                              fontSize: 17,
                              color: Theme.of(context).colorScheme.primary),),
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
                        Text(widget.movies.releaseDate.toString(),style: TextStyle(
                            fontFamily: GoogleFonts.rubik().fontFamily,
                            fontSize: 17,
                            color: Theme.of(context).colorScheme.primary),),
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
                              color: Theme.of(context).colorScheme.primary),),
                        )
                      ],
                    ),
                    const SizedBox(height: 10,),
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
                            barValue: widget.movies.voteAverage,
                            textStyle: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontFamily: GoogleFonts.rubik().fontFamily,
                                fontSize: 17,),
                    ),
                    const SizedBox(height: 20,),
                    FutureBuilder(
                        future: homeScreenController.getCastList(widget.movies.id, http.Client()),
                        builder: (context, snapshot){
                          if(snapshot.hasError){
                            print(snapshot.error.toString());
                              return const Center(
                                child: Text("Something went wrong."),
                              );
                          }else if(snapshot.hasData){
                            return CastListWidget(snapshot: snapshot);
                          }else{
                            return SpinKitWave(
                              color: Theme.of(context).colorScheme.secondary,
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
                        future: homeScreenController.getSimilarMovies(widget.movies.id, http.Client()),
                        builder: (context, snapShot){
                          if(snapShot.hasError){
                            return const Center(child:  Text('Something went wrong'));
                          }else if(snapShot.hasData){
                            return Padding(
                              padding: const EdgeInsets.only(top: 10, bottom: 10),
                              child: CarouselWidget(snapshot: snapShot),
                            );
                          }else{
                            return SpinKitWave(
                              color: Theme.of(context).colorScheme.secondary,
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
