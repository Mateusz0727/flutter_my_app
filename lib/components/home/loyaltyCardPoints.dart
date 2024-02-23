import 'package:flutter/material.dart';

class LoyaltyCardPoints extends StatelessWidget {
  final Future<int> countUserpoint;
  const LoyaltyCardPoints({Key? key, required this.countUserpoint})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: countUserpoint,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            int count = snapshot.data!;
            List<Widget> points = [];

            for (int i = 0; i < count; i++) {
              points.add(Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: CircleAvatar(
                  backgroundColor: Color(0xffc3c46c),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('images/logo.jpg'),
                  ),
                ),
              ));
            }

            for (int i = count; i < 9; i++) {
              points.add(
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: CircleAvatar(
                    backgroundColor: Color(0xffc3c46c),
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
                physics: NeverScrollableScrollPhysics(),
                children: points,
              ),
            );
          }
        }
      },
    );
  }
}
