// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_my_app/screens/auth/register.dart';
import 'package:flutter_my_app/services/auth/authService.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: TextFormField(
                          controller: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Wpisz email';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(), labelText: "Email"),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
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
                                border: OutlineInputBorder(),
                                labelText: "Hasło"),
                          )),
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
                                    if (_formKey.currentState!.validate()) {
                                      _authService.login(
                                          context,
                                          passwordController.text.toString(),
                                          emailController.text.toString());
                                    }
                                  },
                                  child: const Text('Zaloguj'),
                                ))),
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 16.0),
                                child: Center(
                                    child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const RegisterPage()));
                                  },
                                  child: const Text('Utwóz konto'),
                                )))
                          ]),
                      // GestureDetector(
                      //   onTap: () {
                      //     login(emailController.text.toString(),
                      //         passwordController.text.toString());
                      //   },
                      //   child: Container(
                      //     height: 50,
                      //     decoration: BoxDecoration(
                      //         color: Colors.green,
                      //         borderRadius: BorderRadius.circular(10)),
                      //     child: Center(
                      //       child: Text('Login'),
                      //     ),
                      //   ),
                      // )
                    ]))),
      ),
    );
  }
}
