// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_my_app/models/userPoints.dart';

class LoyaltyCardPoints extends StatelessWidget {
  final UserPointsModel countUserpoint;
  const LoyaltyCardPoints({Key? key, required this.countUserpoint})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Widget> points = [];

    for (int i = 0; i < countUserpoint.points % 10; i++) {
      points.add(
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: CircleAvatar(
            backgroundColor: Color(0xffc3c46c),
            child: CircleAvatar(
              backgroundImage: AssetImage('images/logo.jpg'),
            ),
          ),
        ),
      );
    }

    for (int i = countUserpoint.points % 10; i < 9; i++) {
      points.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: CircleAvatar(
            backgroundColor: const Color(0xffc3c46c),
            radius: 10,
            child: Text(
              (i + 1).toString(),
              style: TextStyle(
                fontSize: 24,
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          ),
        ),
      );
    }
    return Flexible(
      fit: FlexFit.loose,
      child: GridView.count(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: MediaQuery.of(context).viewInsets.bottom,
        ),
        childAspectRatio: 1.5,
        crossAxisCount: 3,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: points,
      ),
    );
  }
}
