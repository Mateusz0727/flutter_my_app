import 'package:flutter/material.dart';
import 'package:flutter_my_app/screens/auth/login.dart';
import 'package:flutter_my_app/screens/home/home.dart';
import 'package:flutter_my_app/screens/loyalty/loyaltyCard.dart';
import 'package:flutter_my_app/storage/SecureStorage.dart';

class Layout extends StatefulWidget {
  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int currentPageIndex = 0;
  final database = SecureDatabase();
  Future<bool> isLogged() async {
    var b = await database.read("jwt");
    return b != null ? b.isNotEmpty : false;
  }

  void changePageIndex(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isLogged(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          if (snapshot.data == true) {
            return Scaffold(
              bottomNavigationBar: Container(
                  color: Colors.white,
                  child: NavigationBar(
                    onDestinationSelected: (int index) {
                      setState(() {
                        currentPageIndex = index;
                      });
                    },
                    backgroundColor: Color(0xffC49A6C),
                    indicatorColor: Color(0xffc3c46c),
                    selectedIndex: currentPageIndex,
                    destinations: const <Widget>[
                      NavigationDestination(
                        selectedIcon: Icon(
                          Icons.home,
                          color: Colors.white,
                        ),
                        icon: Icon(
                          Icons.home_outlined,
                          color: Colors.white,
                        ),
                        label: 'Strona główna',
                      ),
                      NavigationDestination(
                          icon: Icon(
                            Icons.qr_code_outlined,
                            color: Colors.white,
                          ),
                          label: "Karta")
                    ],
                  )),
              body: <Widget>[
                /// Home page
                SingleChildScrollView(
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height - 80,
                        child: Home(changePageIndex))),
                LoyaltyCard()
              ][currentPageIndex],
            );
          } else {
            return LoginPage();
          }
        }
      },
    );
  }
}
