// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ssd_secure_app/Models/MessageModel.dart';
import 'package:ssd_secure_app/Widgets/snack_bar.dart';
import 'package:ssd_secure_app/constants.dart';
import 'package:ssd_secure_app/sharedPrefs.dart';

class MessageProvider extends ChangeNotifier {
  String URL = 'https://ssd-mobile-application.herokuapp.com/api';
  Message message = Message();
  List<Message> messageList = [];

  Future<void> createMessage(
    BuildContext context,
    String message,
  ) async {
    String userToken = await SharedPref.readString('userToken');
    Map<String, dynamic> body = {
      "message": message,
    };
    try {
      final response = await http.post(
        Uri.parse('$URL/message'),
        body: jsonEncode(body),
        headers: {
          'x-auth-token': userToken,
          'Content-Type': 'application/json',
        },
      );
      switch (response.statusCode) {
        case 200:
          final json = jsonDecode(response.body);
          if (json['status'] == 'success') {
            ScaffoldMessenger.of(context).showSnackBar(successSnackBar(Constants.successfulCreate));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(Constants.jasonResponseError));
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

  Future<List<Message>> getMessageList(
    BuildContext context,
  ) async {
    String userToken = await SharedPref.readString('userToken');
    try {
      final response = await http.get(
        Uri.parse('$URL/message'),
        headers: {
          'x-auth-token': userToken,
          'Accept': 'application/json',
        },
      );
      switch (response.statusCode) {
        case 200:
          final json = jsonDecode(response.body);
          if (json['status'] == 'success') {
            messageList = [];
            for (var i = 0; i < json['result'].length; i++) {
              messageList.add(Message.fromJson(json['result'][i]));
            }
            return messageList;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(Constants.jasonResponseError));
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

  Future<void> deleteMessage(
    BuildContext context,
    String messageID,
  ) async {
    String userToken = await SharedPref.readString('userToken');
    try {
      final response = await http.delete(
        Uri.parse('$URL/message/$messageID'),
        headers: {
          'x-auth-token': userToken,
        },
      );
      switch (response.statusCode) {
        case 200:
          final json = jsonDecode(response.body);
          if (json['status'] == 'success') {
            ScaffoldMessenger.of(context).showSnackBar(successSnackBar(Constants.successfulDelete));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(Constants.jasonResponseError));
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
}
