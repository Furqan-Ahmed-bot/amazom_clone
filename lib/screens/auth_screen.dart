// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, deprecated_member_use, unnecessary_new, unused_field

import 'dart:convert';

import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum Auth {
  signin,
  signup,
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthServices authService = AuthServices();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void signUpUser() {
    authService.signUpUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text);
  }

  void signInUser() {
    authService.signInUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                'Welcome',
                style: TextStyle(fontSize: 20),
              ),
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Radio(
                        activeColor: GlobalVariables.secondaryColor,
                        value: Auth.signup,
                        groupValue: _auth,
                        onChanged: (Auth? val) {
                          setState(() {
                            _auth = val!;
                          });
                        },
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Create Account.',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              if (_auth == Auth.signup)
                Container(
                  height: 300,
                  width: 380,
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 350,
                        child: Column(
                          children: [
                            TextField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Name"),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Email"),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Password"),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 50,
                              width: 360,
                              child: RaisedButton(
                                color: GlobalVariables.secondaryColor,
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                                onPressed: () {
                                  signUpUser();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Radio(
                        activeColor: GlobalVariables.secondaryColor,
                        value: Auth.signin,
                        groupValue: _auth,
                        onChanged: (Auth? val) {
                          setState(() {
                            _auth = val!;
                          });
                        },
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Sign-In.',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              if (_auth == Auth.signin)
                Container(
                  height: 250,
                  width: 380,
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 350,
                        child: Column(
                          children: [
                            TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Email"),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Password"),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 50,
                              width: 360,
                              child: RaisedButton(
                                color: GlobalVariables.secondaryColor,
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                                onPressed: () {
                                  signInUser();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future register() async {
    String url = 'http://10.0.2.2:3000/api/signup/';
    var data = {
      'name': _nameController.text,
      'email': _emailController.text,
      'password': _passwordController.text,
    };
    var result = await http.post(
      Uri.parse(url),
      body: jsonEncode(data),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    //var msg = jsonDecode(result.body);
    if (result.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('User Registered')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Can not register')));
    }
  }
}
