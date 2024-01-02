import 'package:flutter/cupertino.dart';

import '../utils/colours.dart';

class ExploreListWidget extends StatelessWidget {
  const ExploreListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 5),
                child: Container(
                  color: Colours.palletRed,
                  width: 170,
                  height: 250,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 5),
                child: Container(
                  color: Colours.palletRed,
                  width: 170,
                  height: 250,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}