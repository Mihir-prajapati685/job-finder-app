import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class JobProvider with ChangeNotifier {
  List<Map<String, dynamic>> _jobs = [];

  List<Map<String, dynamic>> get jobs => _jobs;

  Future<void> fetchJobs() async {
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString('token');

    final url =
        Uri.parse('http://localhost:8084/job/get'); // ✅ Replace with actual URL

    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': '$token'
      });

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _jobs = data.map((job) => job as Map<String, dynamic>).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load jobs');
      }
    } catch (error) {
      print('Error fetching jobs: $error');
    }
  }

  Future<void> searchJobs(String keyword) async {
    final url =
        Uri.parse('http://localhost:8084/jobpost/search?keyword=$keyword');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        _jobs = data.cast<Map<String, dynamic>>();
        notifyListeners();
      } else {
        throw Exception('Failed to load jobs');
      }
    } catch (e) {
      throw Exception('Search failed: $e');
    }
  }
}
