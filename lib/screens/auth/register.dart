import 'package:flutter/material.dart';
import 'package:flutter_my_app/screens/auth/login.dart';
import 'package:flutter_my_app/services/auth/authService.dart';
import 'package:flutter_my_app/storage/SecureStorage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  @override
  _RegisterPage createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController givenNameController = TextEditingController();
  TextEditingController surNameController = TextEditingController();
  final _authService = AuthService();
  final _formRegisterKey = GlobalKey<FormState>();
  final database = SecureDatabase();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _formRegisterKey,
          child: Center(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: TextFormField(
                        controller: givenNameController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Wpisz swoje imie';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: "Imię"),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: TextFormField(
                        controller: surNameController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Wpisz swoje nazwisko';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Nazwisko"),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Wpisz swój email';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: "Email"),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Wpisz hasło';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: "Hasło"),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 16.0),
                            child: Center(
                                child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                              },
                              child: const Text('Masz konto?'),
                            ))),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 16.0),
                            child: Center(
                                child: ElevatedButton(
                              onPressed: () {
                                print(database.read("jwt"));
                              },
                              child: const Text('Masz ?'),
                            ))),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 16.0),
                            child: Center(
                                child: ElevatedButton(
                              onPressed: () {
                                if (_formRegisterKey.currentState!.validate()) {
                                  _authService.register(
                                      context,
                                      emailController.text.toString(),
                                      passwordController.text.toString(),
                                      givenNameController.text.toString(),
                                      surNameController.text.toString());
                                }
                              },
                              child: const Text('Zarejestruj się'),
                            )))
                      ],
                    )
                  ],
                )),
          )),
    );
  }
}
