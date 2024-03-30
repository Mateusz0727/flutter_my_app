import 'package:flutter/material.dart';
import 'package:flutter_my_app/components/home/loyaltyCardPoints.dart';
import 'package:flutter_my_app/components/home/topbackground.dart';
import 'package:flutter_my_app/models/userPoints.dart';
import 'package:flutter_my_app/services/userPoints/userPointsServices.dart';

class Home extends StatelessWidget {
  final Function(int) changePageIndex;
  final UserPointsService userPointsService = UserPointsService();
  late final Future<UserPointsModel> countUserPoints;

  Home(this.changePageIndex, {super.key}) {
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
                const TopBackground(),
                const Padding(
                  padding: EdgeInsets.only(top: 70),
                  child: Text(
                    'Lorem Ipsum',
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry s standard dummy text ever since the 1500s',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                FutureBuilder<UserPointsModel>(
                  future: countUserPoints,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else {
                      if (snapshot.data != null && snapshot.data!.points >= 0) {
                        return LoyaltyCardPoints(
                            countUserpoint: snapshot.data!);
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
              backgroundColor: Colors.white,
              radius: 65,
              child: ClipOval(
                child: Image.asset('images/logo.jpg'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
