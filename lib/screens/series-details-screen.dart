import 'package:flutter/material.dart';
import 'package:mflix/models/series-model.dart';

class SeriesDetailsScreen extends StatelessWidget {
  const SeriesDetailsScreen({
    super.key,
    required this.series,
  });

  final SeriesModel series;
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(child: Text(series.originalName),),
    );
  }
}
