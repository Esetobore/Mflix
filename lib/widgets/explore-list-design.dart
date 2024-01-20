import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:mflix/screens/explore-screen.dart';
import 'package:mflix/screens/series-details-screen.dart';
import '../screens/movies-details-screen.dart';
import '../utils/api-endpoint.dart';
import '../utils/colours.dart';

class ExploreListWidget extends StatelessWidget {
   const ExploreListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: SizedBox(
              width: 180,
              height: 4300,
              child: FutureBuilder(
                   future: exploreScreenController.getPopularMovies(),
                   builder: (context, snapshot) {
                     if(snapshot.hasError){
                       return const Text("No Internet Connection Found");}
                     if (snapshot.hasData){
                       return ListView.builder(
                         scrollDirection: Axis.vertical,
                         itemCount: snapshot.data?.length ?? 0,
                         physics: const NeverScrollableScrollPhysics(),
                         itemBuilder: (context, index) {
                           final posterPath = snapshot.data?[index].posterPath;
                           return Padding(
                             padding: const EdgeInsets.only(top: 5, bottom: 10,left: 10),
                             child: Row(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 GestureDetector(
                                   onTap: (){
                                     Get.to(() => MoviesDetailsScreen(movies: snapshot.data![index]));
                                   },
                                   child: SizedBox(
                                       height: 200,
                                       width: 150,
                                       child: Image.network(
                                         '${ApiEndPoints.imagePath}$posterPath',
                                         filterQuality: FilterQuality.medium,
                                         fit: BoxFit.cover,
                                       )),
                                 ),
                               ],
                             ),
                           );
                         },
                       );
                     }else{
                       return const SpinKitWave(
                         color: Colours.palletRed,
                         size: 50.0,
                       );
                     }
                   }
              ),
            ),
          ),
          SizedBox(
            width: 200,
            height: 4300,
            child: FutureBuilder(
                future: exploreScreenController.getPopularSeries(),
                builder: (context, snapshot) {
                  if(snapshot.hasError){
                    return const Text('Please Reload App');
                  }
                  if (snapshot.hasData){
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data?.length ?? 0,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final posterPath = snapshot.data?[index].posterPath;
                        return Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 10,left: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Get.to(() => SeriesDetailsScreen(series: snapshot.data![index]));
                                },
                                child: SizedBox(
                                    height: 200,
                                    width: 150,
                                    child: Image.network(
                                      '${ApiEndPoints.imagePath}$posterPath',
                                      filterQuality: FilterQuality.medium,
                                      fit: BoxFit.cover,
                                    )),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }else{
                    return const SpinKitWave(
                      color: Colours.palletRed,
                      size: 50.0,
                    );
                  }
                }
            ),
          ),
        ],
      ),
    );
  }
}