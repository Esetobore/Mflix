import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mflix/controller/home-screen-controller.dart';
import 'package:mflix/models/movies-model.dart';
import 'package:mflix/utils/api-endpoint.dart';
import 'package:mflix/utils/colours.dart';
import 'package:mflix/widgets/cast-list-design.dart';
import 'package:mflix/widgets/custom-buttons-fill.dart';
import '../models/cast-model.dart';
import '../models/movie-genre-model.dart';

class MoviesDetailsScreen extends StatefulWidget {

  const MoviesDetailsScreen({
    super.key,
    required this.movies,
  });

  final MoviesModel movies;


  @override
  State<MoviesDetailsScreen> createState() => _MoviesDetailsScreenState();
}
final HomeScreenController homeScreenController = Get.put(HomeScreenController());
late final List<MovieGenreModel> movieGenre;
late final List<CastModel> castList;


class _MoviesDetailsScreenState extends State<MoviesDetailsScreen> {


  @override
  void initState() {
    super.initState();
    homeScreenController.getMovieGenreList().then((genreList){
      setState(() {
        movieGenre = genreList;
      });
    });
  }

  List getGenresNames() {
    return widget.movies.genre
        .map((id) => movieGenre.firstWhere((genre)
    => genre.id == id).genreName).toList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            onPressed: (){}),
                        IconButtonWithText(
                            icon: Icons.bookmark_add,
                            text: 'Add to List',
                            onPressed: (){})
                      ],
                    ),
                    const SizedBox(height: 12,),
                    SingleChildScrollView(
                      child: Text(widget.movies.overview,
                        style: TextStyle(
                            fontFamily: GoogleFonts.rubik().fontFamily,
                            fontSize: 18,
                            color: Colours.palletWhite),),
                    ),

                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        Text('Aired: ',style: TextStyle(
                            fontFamily: GoogleFonts.rubik().fontFamily,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colours.palletBlue),),
                        Text(widget.movies.releaseDate,style: TextStyle(
                            fontFamily: GoogleFonts.rubik().fontFamily,
                            fontSize: 18,
                            color: Colours.palletWhite),),
                      ],
                    ),

                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        Text('Genre: ',style: TextStyle(
                            fontFamily: GoogleFonts.rubik().fontFamily,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colours.palletRed),),
                        Text(getGenresNames().join(', '),style: TextStyle(
                            fontFamily: GoogleFonts.rubik().fontFamily,
                            fontSize: 18,
                            color: Colours.palletWhite),)
                      ],
                    ),
                    const SizedBox(height: 10,),
                    FutureBuilder(
                        future: homeScreenController.getCastList(widget.movies.id),
                        builder: (context, snapshot){
                          if(snapshot.hasError){
                            return Center(
                              child: Text("CastListBuilder: ${snapshot.error.toString()}"),
                            );
                          }else if(snapshot.hasData){
                            print('Cast List: ${snapshot.data.toString()}');
                            return CastListWidget(snapshot: snapshot);
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
            ),
          ),
        ],
      ),
    );
  }
}
