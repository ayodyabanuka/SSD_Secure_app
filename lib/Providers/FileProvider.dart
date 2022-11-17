import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ssd_secure_app/Models/FileModel.dart';
import 'package:http/http.dart' as http;
import 'package:ssd_secure_app/constants.dart';
import 'package:ssd_secure_app/sharedPrefs.dart';

import '../Widgets/snack_bar.dart';

class FileProvider extends ChangeNotifier {
  String URL = 'https://ssd-mobile-application.herokuapp.com/api';

  FilesModel file = FilesModel();
  List<FilesModel> fileList = [];

  Future<List<FilesModel>> getFileList(BuildContext context) async {
    String userToken = await SharedPref.readString('userToken');

    try {
      final response = await http.get(
        Uri.parse('$URL/file'),
        headers: {
          'x-auth-token': userToken,
          'Accept': 'application/json',
        },
      );
      switch (response.statusCode) {
        case 200:
          final json = jsonDecode(response.body);
          if (json['status'] == 'success') {
            fileList = [];
            for (var i = 0; i < json['result'].length; i++) {
              fileList.add(FilesModel.fromJson(json['result'][i]));
            }
            return fileList;
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(errorSnackBar(Constants.jasonResponseError));
          }
          notifyListeners();
          break;
        default:
          ScaffoldMessenger.of(context)
              .showSnackBar(errorSnackBar(Constants.jasonResponseError));
          notifyListeners();
          break;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(e.toString()));
    }
  }

  static Future<dynamic> saveFile(
    file,
  ) async {
    String userToken = await SharedPref.readString('userToken');
    try {
      final request = await http.MultipartRequest(
        'POST',
        Uri.parse('https://ssd-mobile-application.herokuapp.com/api/file'),
      );
      request.headers['x-auth-token'] = userToken;
      request.headers['Content-Type'] = 'multipart/form-data';
      request.files.add(
        await http.MultipartFile.fromPath(
          "file",
          file.path.toString(),
        ),
      );
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      print(response.body);
    } catch (e) {
      print("error");
    }
  }
}
