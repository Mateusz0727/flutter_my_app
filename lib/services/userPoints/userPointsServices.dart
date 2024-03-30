// ignore_for_file: file_names

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_my_app/models/userPoints.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_my_app/security/jwtToken.dart';
import 'package:flutter_my_app/services/apiConnection.dart';
import 'package:flutter_my_app/storage/SecureStorage.dart';

class UserPointsService {
  final database = SecureDatabase();
  Future<UserPointsModel> fetchData() async {
    String? jwt = await database.read("jwt");
    if (jwt != null) {
      JwtToken jwtToken = JwtToken.fromJson(json.decode(jwt));
      String token = jwtToken.token;
      String id = jwtToken.guidId;
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer  $token',
      };
      var response = await http.get(
          Uri.parse("${ApiConstants.baseApiUrl}/api/UserPoints/id?id=$id"),
          headers: headers);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        UserPointsModel data = UserPointsModel.fromJson(jsonData);
        return data;
      } else {
        if (kDebugMode) {
          print('Failed to fetch QR data');
        }
        return UserPointsModel(points: 0, countOfPrize: 0);
      }
    }
    return UserPointsModel(points: 0, countOfPrize: 0);
  }
}
