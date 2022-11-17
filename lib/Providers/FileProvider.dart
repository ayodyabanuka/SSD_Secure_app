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
        print(body);
        final data = body['result'] as List;
        print(data);

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

  SaveFile() async {}
}
