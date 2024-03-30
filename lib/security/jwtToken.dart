// ignore_for_file: file_names

class JwtToken {
  final String token;
  final String userName;
  final dynamic
      validity; // Możesz zmienić na odpowiedni typ, np. int lub DateTime
  final dynamic refreshToken;
  final int id;
  final dynamic emailId;
  final String guidId;
  final DateTime expiredTime;

  JwtToken({
    required this.token,
    required this.userName,
    required this.validity,
    required this.refreshToken,
    required this.id,
    required this.emailId,
    required this.guidId,
    required this.expiredTime,
  });

  factory JwtToken.fromJson(Map<String, dynamic> json) {
    return JwtToken(
      token: json['token'] as String,
      userName: json['userName'] as String,
      validity: json['validity'],
      refreshToken: json['refreshToken'],
      id: json['id'] as int,
      emailId: json['emailId'],
      guidId: json['guidId'] as String,
      expiredTime: DateTime.parse(json['expiredTime'] as String),
    );
  }
}
