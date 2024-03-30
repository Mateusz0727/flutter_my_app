// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_my_app/models/UserQrCode.dart';
import 'package:flutter_my_app/security/jwtToken.dart';
import 'package:flutter_my_app/services/apiConnection.dart';
import 'package:flutter_my_app/storage/SecureStorage.dart';
import 'package:http/http.dart' as http;

class QrCodesService {
  final database = SecureDatabase();
  Future<String> fetchUserQrCode() async {
    String? jwt = await database.read("jwt");
    if (jwt != null) {
      JwtToken jwtToken = JwtToken.fromJson(json.decode(jwt));
      String token = jwtToken.token;
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer  $token',
      };
      var response = await http.get(
          Uri.parse("${ApiConstants.baseApiUrl}/api/qrCode"),
          headers: headers);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        jsonData['Token'] = jwtToken.token;
        UserQrCode data = UserQrCode.fromJson(jsonData);
        return response.body;
      } else {
        if (kDebugMode) {
          print('Failed to fetch QR data');
        }
        return "";
      }
    }
    return "";
  }

  Future<String> fetchUserPrizeQrCode() async {
    String? jwt = await database.read("jwt");
    if (jwt != null) {
      JwtToken jwtToken = JwtToken.fromJson(json.decode(jwt));
      String token = jwtToken.token;
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer  $token',
      };
      var response = await http.get(
          Uri.parse(
              "${ApiConstants.baseApiUrl}/api/qrCode/generateQrCodeForPrize"),
          headers: headers);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        if (kDebugMode) {
          print('Failed to fetch QR data');
        }
        return "";
      }
    }
    return "";
  }
}
