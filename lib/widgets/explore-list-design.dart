import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mflix/controller/explore-screen-controller.dart';
import 'package:mflix/screens/explore-screen.dart';
import 'package:mflix/screens/series-details-screen.dart';

import '../screens/movies-details-screen.dart';
import '../utils/api-endpoint.dart';
import '../utils/colours.dart';

class ExploreListWidget extends StatelessWidget {
   ExploreListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FutureBuilder(
               future: exploreScreenController.getPopularMovies(),
               builder: (context, snapshot) {
                 if(snapshot.hasError){
                   return Text('Error: ${snapshot.error}');
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
                             Padding(
                               padding: const EdgeInsets.only(left: 10,right: 5),
                               child: GestureDetector(
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
        Expanded(
          child: FutureBuilder(
              future: exploreScreenController.getPopularSeries(),
              builder: (context, snapshot) {
                if(snapshot.hasError){
                  return Text('Error: ${snapshot.error}');
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
                            Padding(
                              padding: const EdgeInsets.only(left: 10,right: 5),
                              child: GestureDetector(
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
    );
  }
}