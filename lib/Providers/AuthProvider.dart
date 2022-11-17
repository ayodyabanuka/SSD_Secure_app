import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ssd_secure_app/Models/UserModel.dart';
import 'package:ssd_secure_app/Widgets/snack_bar.dart';
import 'package:ssd_secure_app/sharedPrefs.dart';

class AuthProvider extends ChangeNotifier {
  String URL = 'https://ssd-mobile-application.herokuapp.com/api';
  User user = User();
  List<User> userList = [];

  Future<void> userLogin(
    BuildContext context,
    String email,
    String password,
  ) async {
    Map<String, dynamic> body = {
      "email": email,
      "password": password,
    };
    try {
      print(body);
      final response = await http.post(
        Uri.parse('https://ssd-mobile-application.herokuapp.com/api/user/login'),
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      print(response.body);
      switch (response.statusCode) {
        case 200:
          notifyListeners();
          break;
        default:
          notifyListeners();
          break;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(e));
    }
  }

  Future<void> userAuth(
    BuildContext context,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$URL/user/auth'),
        headers: {
          'x-auth-token': '',
        },
      );
      switch (response.statusCode) {
        case 200:
          final data = jsonDecode(response.body);
          user = User.fromJson(data['result']);
          SharedPref.save('User', user);
          notifyListeners();
          break;
        default:
          notifyListeners();
          break;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(e));
    }
  }

  Future<void> getUsers(
    BuildContext context,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('$URL/user'),
      );
      switch (response.statusCode) {
        case 200:
          notifyListeners();
          break;
        default:
          notifyListeners();
          break;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(e));
    }
  }

  Future<void> createUser(
    BuildContext context,
    String username,
    String email,
    String password,
    String type,
  ) async {
    Map<String, dynamic> body = {
      "username": username,
      "email": email,
      "password": password,
      "type": type,
    };
    try {
      final response = await http.post(
        Uri.parse('$URL/user/auth'),
        body: jsonEncode(body),
      );
      switch (response.statusCode) {
        case 200:
          notifyListeners();
          break;
        default:
          notifyListeners();
          break;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(e));
    }
  }

  Future<void> updateUser(
    BuildContext context,
    String username,
    String email,
    String password,
    String type,
  ) async {
    Map<String, dynamic> body = {
      "username": username,
      "email": email,
      "password": password,
      "type": type,
    };
    try {
      final response = await http.put(
        Uri.parse('$URL/user'),
        body: jsonEncode(body),
        headers: {
          'x-auth-token': '',
        },
      );
      switch (response.statusCode) {
        case 200:
          notifyListeners();
          break;
        default:
          notifyListeners();
          break;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(e));
    }
  }
}
