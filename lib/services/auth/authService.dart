// ignore_for_file: file_names, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_app/models/user.dart';
import 'package:flutter_my_app/screens/loyalty/loyaltyCard.dart';
import 'package:flutter_my_app/services/apiConnection.dart';
import 'package:flutter_my_app/storage/SecureStorage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final headers = {'Content-Type': 'application/json'};
  final database = SecureDatabase();

  void login(BuildContext context, String email, password) async {
    try {
      final user = UserLoginModel(email, password);
      final url = Uri.parse("${ApiConstants.baseApiUrl}/login");
      var response = await http.post(url,
          headers: headers, body: jsonEncode(user.toJson()));

      if (response.statusCode == 200) {
        database.write("jwt", response.body.toString());
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoyaltyCard()));
        if (kDebugMode) {
          print(await database.read("jwt"));
        }
      }
      if (response.statusCode == 401) {
        if (kDebugMode) {
          print(response.toString());
        }
        const snackBar = SnackBar(
          content: Text('Nieprawidłowy login lub hasło.'),
          duration: Duration(seconds: 3),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  void register(
      BuildContext context, String email, password, givenName, surName) async {
    try {
      final userRegister =
          UserRegisterModel(email, password, givenName, surName);
      final url = Uri.parse("${ApiConstants.baseApiUrl}/register");
      await http.post(url,
          headers: headers, body: jsonEncode(userRegister.toJson()));
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
