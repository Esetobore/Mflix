import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/api-endpoint.dart';
import '../utils/colours.dart';

class CastListWidget extends StatelessWidget {

  AsyncSnapshot snapshot;

   CastListWidget({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
          return SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final cast = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage('${ApiEndPoints.imagePath}${cast.profilePath}'
                        )
                      ),
                      const SizedBox(width: 8),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 120,
                            child: Text(cast.originalName,
                                textAlign: TextAlign.center, style: TextStyle(
                                    fontFamily: GoogleFonts.rubik().fontFamily,
                                    fontSize: 13,
                                    color: Colours.palletWhite)),
                          ),
                          SizedBox(
                            width: 120,
                            child: Text(cast.character,
                                textAlign: TextAlign.center, style: TextStyle(
                                    fontFamily: GoogleFonts.rubik().fontFamily,
                                    fontSize: 13,
                                    color: Colours.palletWhite)),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          );
        }
      }