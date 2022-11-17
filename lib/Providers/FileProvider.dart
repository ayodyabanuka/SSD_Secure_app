// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

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
        ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(Constants.jasonResponseError));
        return fileList;
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
        Uri.parse(''),
      );
      request.headers['x-auth-token'] = userToken;
      request.files.add(
        await http.MultipartFile.fromPath(
          file.path.split('/').last,
          file.path.toString(),
        ),
      );
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
    } catch (e) {}
  }
}
