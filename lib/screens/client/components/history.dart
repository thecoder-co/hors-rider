import 'package:flutter/material.dart';
import 'package:rider/constants.dart';

class History extends StatelessWidget {
  const History({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 10,
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 20,
        );
      },
      itemBuilder: (BuildContext context, int index) {
        return ClipRRect(
          child: Container(
            color: kPrimaryLightColor,
            width: MediaQuery.of(context).size.width * 0.8,
            height: 100,
            child: Row(
              children: [
                IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.bike_scooter,
                    color: kPrimaryColor,
                  ),
                  iconSize: 80,
                )
              ],
            ),
          ),
          borderRadius: BorderRadius.circular(15),
        );
      },
    );
  }
}
