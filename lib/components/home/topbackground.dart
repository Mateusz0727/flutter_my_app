// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class TopBackground extends StatefulWidget {
  const TopBackground({super.key});

  @override
  _TopBackgroundState createState() => _TopBackgroundState();
}

class _TopBackgroundState extends State<TopBackground> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/coffeBackground2.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
