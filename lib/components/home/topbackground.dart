import 'package:flutter/material.dart';

class TopBackground extends StatefulWidget {
  @override
  _TopBackgroundState createState() => _TopBackgroundState();
}

class _TopBackgroundState extends State<TopBackground> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/coffeBackground2.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
