// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_my_app/models/UserQrCode.dart';
import 'package:flutter_my_app/security/jwtToken.dart';
import 'package:flutter_my_app/services/apiConnection.dart';
import 'package:flutter_my_app/storage/SecureStorage.dart';

import 'package:http/http.dart' as http;

class QRCodeSimulator {
  final database = SecureDatabase();
  Future<void> sendQRCodeDataToServer(UserQrCode qrCodeData) async {
    String? jwt = await database.read("jwt");
    if (jwt != null) {
      JwtToken jwtToken = JwtToken.fromJson(json.decode(jwt));
      String token = jwtToken.token;
      final url = Uri.parse('${ApiConstants.baseApiUrl}/api/UserPoints');
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer  $token',
        },
        body: jsonEncode(qrCodeData.toJson()),
      );

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('QR code data sent successfully!');
        }
        // Możesz przetwarzać odpowiedź serwera tutaj
      } else if (response.statusCode == 400) {
        if (kDebugMode) {
          print(response.body);
        }
      } else {
        if (kDebugMode) {
          print(
              'Failed to send QR code data. Error code: ${response.statusCode}');
        }
      }
    }
  }
}
