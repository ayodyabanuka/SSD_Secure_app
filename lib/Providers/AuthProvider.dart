// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ssd_secure_app/Models/UserModel.dart';
import 'package:ssd_secure_app/Widgets/snack_bar.dart';
import 'package:ssd_secure_app/constants.dart';
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
        Uri.parse('$URL/user/login'),
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      switch (response.statusCode) {
        case 200:
          final json = jsonDecode(response.body);
          if (json['status'] == 'success') {
            ScaffoldMessenger.of(context).showSnackBar(successSnackBar(Constants.successfulCompleted));
            SharedPref.saveString('userToken', json['token']);
            await userAuth(context);
            Navigator.pushNamed(context, '/HomeScreen');
          } else {
            ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(Constants.loginError));
          }
          notifyListeners();
          break;
        default:
          ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(Constants.jasonResponseError));
          notifyListeners();
          break;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(e.toString()));
    }
  }

  Future<void> userAuth(
    BuildContext context,
  ) async {
    String userToken = await SharedPref.readString('userToken');
    try {
      final response = await http.post(
        Uri.parse('$URL/user/auth'),
        headers: {
          'x-auth-token': userToken,
          'Accept': 'application/json',
        },
      );
      switch (response.statusCode) {
        case 200:
          final data = jsonDecode(response.body);
          user = User.fromJson(data['result']);
          SharedPref.saveObject('User', user);
          notifyListeners();
          break;
        default:
          ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(Constants.jasonResponseError));
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
        headers: {
          'Accept': 'application/json',
        },
      );
      switch (response.statusCode) {
        case 200:
          notifyListeners();
          break;
        default:
          ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(Constants.jasonResponseError));
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
        headers: {
          'Accept': 'application/json',
        },
      );
      switch (response.statusCode) {
        case 200:
          notifyListeners();
          break;
        default:
          ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(Constants.jasonResponseError));
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
  ) async {
    String userToken = await SharedPref.readString('userToken');
    Map<String, dynamic> body = {
      "username": username,
      "email": email,
      "password": password,
    };
    try {
      final response = await http.put(
        Uri.parse('$URL/user'),
        body: jsonEncode(body),
        headers: {
          'x-auth-token': userToken,
          'Accept': 'application/json',
        },
      );
      switch (response.statusCode) {
        case 200:
          userAuth(context);
          Navigator.pushNamedAndRemoveUntil(context, "/ProfileScreen", (Route<dynamic> route) => false);
          notifyListeners();
          break;
        default:
          ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(Constants.jasonResponseError));
          notifyListeners();
          break;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(e));
    }
  }
}
