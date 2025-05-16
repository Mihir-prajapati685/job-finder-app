// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ProfileProvider with ChangeNotifier {
//   String? _username;
//   String? _email;
//   String? _token;

//   String? get username => _username;
//   String? get email => _email;
//   String? get token => _token;

//   Future<void> loadProfileData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     _username = prefs.getString('username');
//     _email = prefs.getString('email');
//     _token = prefs.getString('token');
//     notifyListeners();
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider with ChangeNotifier {
  // Auth info
  String? _username;
  String? _email;
  String? _token;

  // Profile info
  String? headline;
  String? skills;
  String? education;
  String? country;
  String? city;
  String? about;
  String? pronouns;
  String? link;
  String? linkText;
  String? industry;
  String? experience;

  bool isLoading = false;
  bool isfetch = false;

  // Getters
  String? get username => _username;
  String? get email => _email;
  String? get token => _token;

  List<Map<String, dynamic>> userPosts = [];
  bool isPostLoading = false;

  // Load auth info from SharedPreferences
  Future<void> loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _username = prefs.getString('username');
    _email = prefs.getString('email');
    _token = prefs.getString('token');
    notifyListeners();
  }

  Future<void> fetchProfile() async {
    if (_token == null) {
      await loadProfileData(); // Ensure token is loaded
    }

    final url = Uri.parse('http://localhost:8084/profile/get');

    try {
      isLoading = true;
      notifyListeners();

      final response = await http.get(url, headers: {
        'Authorization': '$_token',
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        headline = data['headline'];
        skills = data['skills'];
        education = data['education'];
        country = data['country'];
        city = data['city'];
        about = data['about'];
        pronouns = data['pronoums'];
        link = data['link'];
        linkText = data['linktext'];
        industry = data['industry'];
        experience = data['experience'];

        isfetch = true;
      } else {
        print("No profile found");
      }
    } catch (e) {
      print("Fetch error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateProfile(Map<String, dynamic> body) async {
    if (_token == null) {
      await loadProfileData();
    }

    final Uri url = isfetch
        ? Uri.parse('http://localhost:8084/profile/update') // Update existing
        : Uri.parse('http://localhost:8084/profile/post'); // Create new

    try {
      final response = isfetch
          ? await http.put(
              url,
              headers: {
                'Authorization': '$_token',
                'Content-Type': 'application/json',
              },
              body: json.encode(body),
            )
          : await http.post(
              url,
              headers: {
                'Authorization': '$_token',
                'Content-Type': 'application/json',
              },
              body: json.encode(body),
            );

      if (response.statusCode == 200 || response.statusCode == 201) {
        await fetchProfile(); // Refresh profile after save/update
        print("Profile saved/updated successfully");
      } else {
        print("Save/Update failed: ${response.body}");
      }
    } catch (e) {
      print("Save/Update error: $e");
    }
  }

  Future<void> deleteprofile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    notifyListeners();
  }

  Future<void> fetchUserPosts() async {
    if (_token == null) {
      await loadProfileData(); // Ensure token is available
    }

    final url = Uri.parse('http://localhost:8084/jobpost/get');

    try {
      isPostLoading = true;
      notifyListeners();

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '$_token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        userPosts = data.cast<Map<String, dynamic>>();
      } else {
        print("Failed to fetch posts: ${response.body}");
      }
    } catch (e) {
      print("Error fetching posts: $e");
    } finally {
      isPostLoading = false;
      notifyListeners();
    }
  }
}
