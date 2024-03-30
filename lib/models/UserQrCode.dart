// ignore_for_file: file_names

class UserQrCode {
  final DateTime expiredTime;
  final String id;
  final String token;

  UserQrCode(this.expiredTime, this.id, this.token);

  UserQrCode.fromJson(Map<String, dynamic> json)
      : expiredTime = DateTime.parse(json['ExpiredTime'] as String),
        id = json['Id'] as String,
        token = json['Token'] as String;

  Map<String, dynamic> toJson() {
    return {
      "ExpiredTime": expiredTime.toIso8601String(),
      "Id": id,
      "Token": token,
    };
  }
}
