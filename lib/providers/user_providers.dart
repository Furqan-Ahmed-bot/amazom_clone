// ignore_for_file: unused_field, prefer_final_fields

import 'package:amazon_clone/models/user.dart';
import 'package:flutter/material.dart';

class UserPovider extends ChangeNotifier {
  User _user = User(
      id: '',
      name: '',
      email: '',
      password: '',
      address: '',
      type: '',
      token: '');

      User get user => _user;

      void setUser(String user){
        _user = User.fromJson(user);
        notifyListeners();

      }
}
