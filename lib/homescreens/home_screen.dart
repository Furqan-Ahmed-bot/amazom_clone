import 'package:amazon_clone/providers/user_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserPovider>(context).user;
    return Scaffold(
      body: Center(
        child: Text(user.name

        )
      ),
    );
  }
}