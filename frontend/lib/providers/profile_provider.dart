import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider with ChangeNotifier {
  String? _username;
  String? _email;
  String? _token;

  String? get username => _username;
  String? get email => _email;
  String? get token => _token;

  Future<void> loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _username = prefs.getString('username');
    _email = prefs.getString('email');
    _token = prefs.getString('token');
    notifyListeners();
  }
}
