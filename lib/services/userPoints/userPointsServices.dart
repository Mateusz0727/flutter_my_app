import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_my_app/security/jwtToken.dart';
import 'package:flutter_my_app/services/apiConnection.dart';
import 'package:flutter_my_app/storage/SecureStorage.dart';

class UserPointsService {
  final database = SecureDatabase();
  Future<int> fetchData() async {
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
          Uri.parse(ApiConstants.baseApiUrl + "/api/UserPoints/id?id=$id"),
          headers: headers);
      if (response.statusCode == 200) {
        return int.parse(response.body);
      } else {
        print('Failed to fetch QR data');
        return 0;
      }
    }
    return 0;
  }
}
