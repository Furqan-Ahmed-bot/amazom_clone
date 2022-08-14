// ignore_for_file: prefer_const_constructors

import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/providers/user_providers.dart';
import 'package:amazon_clone/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => UserPovider(),
    ),
  ]  ,child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    
        title: 'Amazon Clone',
        theme: ThemeData(
          
           colorScheme: ColorScheme.light(
            primary: GlobalVariables.secondaryColor
           ),
            scaffoldBackgroundColor: GlobalVariables.backgroundColor,
            appBarTheme: AppBarTheme(
                elevation: 0, iconTheme: IconThemeData(color: Colors.black))),
        home: AuthScreen());
  }
}
