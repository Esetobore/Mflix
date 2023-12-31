import 'package:flutter/material.dart';
import '../utils/api-endpoint.dart';

class CastListWidget extends StatelessWidget {

  AsyncSnapshot snapshot;

   CastListWidget({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
          return SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final cast = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage('${ApiEndPoints.imagePath}${cast.profilePath}'
                        )
                      ),
                      const SizedBox(height: 8),
                      Text(cast.originalName,
                          textAlign: TextAlign.center),
                      const SizedBox(height: 4),
                      Text(cast.character,
                          textAlign: TextAlign.center),
                    ],
                  ),
                );
              },
            ),
          );
        }
      }