// ignore_for_file: use_build_context_synchronously

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
        Uri.parse('$URL/file/'),
        headers: {
          'x-auth-token': userToken,
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final data = body['result'] as List;
        if (fileList.isNotEmpty) {
          return fileList;
        } else {
          for (Map<String, dynamic> item in data) {
            var files = FilesModel.fromJson(item);
            fileList.add(files);
          }
          return fileList;
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(errorSnackBar(Constants.jasonResponseError));
        return fileList;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(e.toString()));
    }
  }

  static Future<dynamic> saveFile(
    File file,
  ) async {
    String userToken = await SharedPref.readString('userToken');
    try {
      final request = await http.MultipartRequest(
        'POST',
        Uri.parse('https://ssd-mobile-application.herokuapp.com/api/file'),
      );
      request.headers['x-auth-token'] = userToken;
      request.headers['Content-Type'] = 'multipart/form-data';
      request.files.add(http.MultipartFile(
          'picture',
          File(file.path).readAsBytes().asStream(),
          File(file.path).lengthSync(),
          filename: file.path.split("/").last));
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      print(response.body);
    } catch (e) {}
  }
}
