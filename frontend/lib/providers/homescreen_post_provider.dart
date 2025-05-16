import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomescreenPostProvider with ChangeNotifier {
  List<Map<String, dynamic>> _posts = [];

  List<Map<String, dynamic>> get posts => _posts;

  Future<void> fetchPosts() async {
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString('token');
    try {
      final response = await http.get(
        Uri.parse('http://localhost:8084/jobpost/all'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '$token'
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print(data);
        _posts = data.cast<Map<String, dynamic>>();
        notifyListeners();
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (error) {
      throw Exception('Something went wrong: $error');
    }
  }
}
