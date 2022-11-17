import 'dart:io';

import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:ssd_secure_app/Models/FileModel.dart';
import 'package:ssd_secure_app/Providers/FileProvider.dart';
import 'package:ssd_secure_app/Utils/appcolors.dart';
import 'package:ssd_secure_app/Widgets/snack_bar.dart';
import 'package:ssd_secure_app/constants.dart';

class Files extends StatefulWidget {
  Files({Key key}) : super(key: key);

  @override
  State<Files> createState() => _FilesState();
}

File selectedFile;

class _FilesState extends State<Files> {
  Future<List<FilesModel>> fileList;
  @override
  void initState() {
    fileList = context.read<FileProvider>().getFileList(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bcColor,
      appBar: AppBar(
        backgroundColor: bcColor,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: const Text(
          "Files",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
                child: FutureBuilder<List<FilesModel>>(
                    future: fileList,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: Text("Loading..."),
                        );
                      } else {
                        return ListView.separated(
                          itemCount: snapshot.data.length,
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(
                            thickness: 1,
                            height: 1,
                            color: Color.fromARGB(255, 204, 204, 204),
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "File Name",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            snapshot.data[index].filename,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      InkWell(
                                        onTap: () {
                                          downloadFile(
                                              snapshot.data[index].filename);
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.all(5),
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color: apppurple,
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: const Icon(Icons.download),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                    })),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: apppurple,
                        borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.attach_file),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Expanded(child: Text("Select image file")),
                InkWell(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: apppurple,
                        borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.send),
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }

  downloadFile(String filename) async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      //add more permission to request here.
    ].request();

    if (statuses[Permission.storage].isGranted) {
      var dir = await DownloadsPathProvider.downloadsDirectory;
      if (dir != null) {
        String savename = filename;
        String savePath = dir.path + "/$savename";
        print(savePath);
        //output:  /storage/emulated/0/Download/banner.png

        try {
          await Dio().download(
              "https://ssd-mobile-application.herokuapp.com/api/files/$filename",
              savePath, onReceiveProgress: (received, total) {
            if (total != -1) {
              print((received / total * 100).toStringAsFixed(0) + "%");
              //you can build progressbar feature too
            }
          });
          ScaffoldMessenger.of(context)
              .showSnackBar(successSnackBar(Constants.successfuldownload));
          print("File is saved to download folder.");
        } on DioError catch (e) {
          print(e.message);
          ScaffoldMessenger.of(context)
              .showSnackBar(errorSnackBar(Constants.jasonResponseError));
        }
      }
    } else {
      print("No permission to read and write.");
    }
  }

  selectImage() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      setState(() {
        selectedFile = imageFile;
      });
    }
  }
}
