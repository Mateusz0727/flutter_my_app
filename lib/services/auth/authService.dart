import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_my_app/models/user.dart';
import 'package:flutter_my_app/screens/loyalty/loyalty.dart';
import 'package:flutter_my_app/services/apiConnection.dart';
import 'package:flutter_my_app/storage/SecureStorage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final headers = {'Content-Type': 'application/json'};
  final database = SecureDatabase();

  void login(BuildContext context, String email, password) async {
    try {
      final user = UserLoginModel(email, password);
      final url = Uri.parse(ApiConstants.baseUrl + "/login");
      var response = await http.post(url,
          headers: headers, body: jsonEncode(user.toJson()));

      if (response.statusCode == 200) {
        database.write("jwt", response.body.toString());
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => QRScreen()));
        print(await database.read("jwt"));
      }
      if (response.statusCode == 401) {
        print(response.toString());
        final snackBar = SnackBar(
          content: Text('Nieprawidłowy login lub hasło.'),
          duration: const Duration(seconds: 3),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void register(
      BuildContext context, String email, password, givenName, surName) async {
    try {
      final userRegister =
          UserRegisterModel(email, password, givenName, surName);
      final url = Uri.parse(ApiConstants.baseUrl + "/register");
      await http.post(url,
          headers: headers, body: jsonEncode(userRegister.toJson()));
    } catch (e) {
      print(e.toString());
    }
  }
}
