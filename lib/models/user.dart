class UserLoginModel {
  final String password;
  final String email;

  UserLoginModel(this.password, this.email);

  UserLoginModel.fromJson(Map<String, dynamic> json)
      : password = json['password'] as String,
        email = json['email'] as String;

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
    };
  }
}

class UserRegisterModel {
  final String givenName;
  final String surName;
  final String email;
  final String password;
  final bool emailConfirmed;
  UserRegisterModel(this.email, this.password, this.givenName, this.surName,
      {this.emailConfirmed = false});
  UserRegisterModel.fromJson(Map<String, dynamic> json)
      : password = json['password'] as String,
        email = json['email'] as String,
        givenName = json['givenName'] as String,
        surName = json['surName'] as String,
        emailConfirmed = json['emailConfirmed'] as bool;

  Map<String, dynamic> toJson() {
    return {
      "givenName": givenName,
      "surName": surName,
      "email": email,
      "password": password,
      "emailConfirmed": emailConfirmed
    };
  }
}
