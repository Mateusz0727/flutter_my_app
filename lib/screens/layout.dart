// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_my_app/screens/auth/login.dart';
import 'package:flutter_my_app/screens/home/home.dart';
import 'package:flutter_my_app/screens/loyalty/getYourPrize.dart';
import 'package:flutter_my_app/screens/loyalty/loyaltyCard.dart';
import 'package:flutter_my_app/storage/SecureStorage.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

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
    if (mounted) {
      setState(() {
        currentPageIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isLogged(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          if (snapshot.data == true) {
            return Scaffold(
              body: IndexedStack(
                index: currentPageIndex,
                children: [
                  Home(changePageIndex),
                  const LoyaltyCard(),
                  const GetYourPrize(),
                ],
              ),
              bottomNavigationBar: BottomAppBar(
                color: const Color(0xffC49A6C),
                shape: const CircularNotchedRectangle(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.home),
                      onPressed: () {
                        changePageIndex(0);
                      },
                      color: Colors.white,
                    ),
                    IconButton(
                      icon: const Icon(Icons.qr_code),
                      onPressed: () {
                        changePageIndex(1);
                      },
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const LoginPage();
          }
        }
      },
    );
  }
}
