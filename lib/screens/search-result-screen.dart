import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../models/media-model.dart';
import '../utils/api-endpoint.dart';
import 'movies-details-screen.dart';

class SearchResultScreen extends StatelessWidget {

  SearchResultScreen({
    Key? key,
    required this.snapshot,
  }) : super(key: key);

  AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
      ),
      body: ListView.builder(
        itemCount: snapshot.data.lenght,
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
      ),
    );
  }
}
