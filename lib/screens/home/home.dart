import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_my_app/components/home/loyaltyCardPoints.dart';
import 'package:flutter_my_app/components/home/topbackground.dart';
import 'package:flutter_my_app/services/userPoints/userPointsServices.dart';

class Home extends StatelessWidget {
  final Function(int) changePageIndex;
  final UserPointsService userPointsService = UserPointsService();
  late final Future<int> countUserPoints;

  Home(this.changePageIndex) {
    countUserPoints = userPointsService.fetchData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                TopBackground(),
                Padding(
                  padding: EdgeInsets.only(top: 70),
                  child: Text(
                    'Lorem Ipsum',
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry s standard dummy text ever since the 1500s',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                FutureBuilder<int>(
                  future: countUserPoints,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      if (snapshot.data != null &&
                          snapshot.data! > 0 &&
                          snapshot.data! % 10 != 0) {
                        return LoyaltyCardPoints(
                            countUserpoint: countUserPoints);
                      } else {
                        return ElevatedButton(
                          onPressed: () {
                            changePageIndex(2);
                          },
                          child: const Text('odbierz nagrodę'),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
          Positioned(
            top: 195,
            left: 0,
            right: 0,
            child: CircleAvatar(
              child: ClipOval(
                child: Image.asset('images/logo.jpg'),
              ),
              backgroundColor: Colors.white,
              radius: 65,
            ),
          ),
        ],
      ),
    );
  }
}
