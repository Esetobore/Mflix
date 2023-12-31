import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mflix/main.dart';
import 'package:mflix/utils/colours.dart';
import 'package:mflix/widgets/default-carousel.dart';
import 'package:mflix/widgets/main-carousel.dart';
import 'package:mflix/widgets/series-carousel.dart';
import '../controller/home-screen-controller.dart';
import 'navbar-screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeScreenController homeScreenController = Get.put(HomeScreenController());
  late ConnectivityResult _connectivityResult;

  @override
  void initState() {
    super.initState();
    checkConnectivity();
  }

  Future<void> checkConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _connectivityResult = connectivityResult;
    });

    if (_connectivityResult == ConnectivityResult.none) {
      showNoInternetDialog();
    }
  }
  Future<void> showNoInternetDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('No Internet Connection'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Please check your internet connection.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Try Again'),
              onPressed: () {
                Navigator.of(context).pop();
                checkConnectivity();
                reloadApp();
              },
            ),
          ],
        );
      },
    );
  }

  void reloadApp() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => NavBarScreen(),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => homeScreenController.isLoading.value
          ? Center(
          child: SpinKitWave(
            color: Theme.of(context).colorScheme.secondary,
            size: 50.0,
          ) )
          : const _BuildScreen()),
    );
  }

}

class _BuildScreen extends StatelessWidget {
  const _BuildScreen();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                            color: Theme.of(context).colorScheme.primary
                        ),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text('Movie Magic Awaits', style: TextStyle(
                            fontFamily: GoogleFonts.rubik().fontFamily,
                            fontSize: 13,
                            color: Theme.of(context).colorScheme.primary
                        ),),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            SizedBox(
              child: FutureBuilder(
                future: HomeScreenController().getTrendingMoviesDay(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("No Internet Connection Found\n Please Reload App"),
                    );
                  } else if (snapshot.hasData) {
                    return  MainCarousel(snapshot: snapshot,);
                  } else {
                    return Center(child: SpinKitWave(
                      color: Theme.of(context).colorScheme.secondary,
                      size: 50.0,
                    ));
                  }
                },
              ),
            ),

            //Trending Movies Carousel
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Top Rated Movies', style: TextStyle(
                      fontFamily: GoogleFonts.rubik().fontFamily,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary
                  ),),
                  Text('See all', style: TextStyle(
                      fontFamily: GoogleFonts.rubik().fontFamily,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colours.palletBlue
                  ),),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            SizedBox(
              child: FutureBuilder(
                future: HomeScreenController().getTopRatedMovies(),
                builder: (context, snapshot){
                  if(snapshot.hasError){
                    return const Center(
                      child: Text("No Internet Connection Found\n Please Reload App"),
                    );
                  }else if (snapshot.hasData){
                    return CarouselWidget(snapshot: snapshot);
                  } else {
                    return Center(child: SpinKitWave(
                      color: Theme.of(context).colorScheme.secondary,
                      size: 50.0,
                    ),);
                  }

                }
              ),
            ),
            //Latest Moves Carousel
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Upcoming Movies', style: TextStyle(
                      fontFamily: GoogleFonts.rubik().fontFamily,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary
                  ),),
                  Text('See all', style: TextStyle(
                      fontFamily: GoogleFonts.rubik().fontFamily,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colours.palletBlue
                  ),),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            SizedBox(
              child: FutureBuilder(
                future: HomeScreenController().getUpcomingMovies(),
                builder: (context, snapshot){
                  if (snapshot.hasError){
                    return const Center(child: Text('No Internet Connection Found\n Please Reload App'),);
                  } else if (snapshot.hasData){
                    return CarouselWidget(snapshot: snapshot);
                  } else{
                    return Center(child: SpinKitWave(
                      color: Theme.of(context).colorScheme.secondary,
                      size: 50.0,
                    ),);
                  }
                }
              ),
            ),
            //Top Rated Series Carousel
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Top Rated Series', style: TextStyle(
                      fontFamily: GoogleFonts.rubik().fontFamily,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary
                  ),),
                  Text('See all', style: TextStyle(
                      fontFamily: GoogleFonts.rubik().fontFamily,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colours.palletBlue
                  ),),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            SizedBox(
              child: FutureBuilder(
                  future: HomeScreenController().getLatestTvSeries(),
                  builder: (context, snapshot){
                    if (snapshot.hasError){
                      return const Text("No Internet Connection Found\n Please Reload App");
                    }else if (snapshot.hasData){
                      return SeriesCarouselWidget(snapshot: snapshot);
                    } else{
                      return  Center(child: SpinKitWave(
                        color:Theme.of(context).colorScheme.secondary,
                        size: 50.0,
                      ),);
                    }
                  }
              ),
            ),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}