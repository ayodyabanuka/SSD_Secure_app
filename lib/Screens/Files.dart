import 'package:flutter/material.dart';
import 'package:ssd_secure_app/Utils/appcolors.dart';

class Files extends StatefulWidget {
  Files({Key key}) : super(key: key);

  @override
  State<Files> createState() => _FilesState();
}

class _FilesState extends State<Files> {
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
                child: ListView.separated(
              itemCount: 10,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                            width: 140, height: 60, child: Placeholder()),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "File Name",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 10),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "FileName.jpg",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.all(5),
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: apppurple,
                              borderRadius: BorderRadius.circular(12)),
                          child: const Icon(Icons.download),
                        ),
                      ],
                    ),
                  ],
                );
              },
            )),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(5),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: apppurple,
                      borderRadius: BorderRadius.circular(12)),
                  child: const Icon(Icons.attach_file),
                ),
                Expanded(child: Text("Select image file")),
                Container(
                  margin: const EdgeInsets.all(5),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: apppurple,
                      borderRadius: BorderRadius.circular(12)),
                  child: const Icon(Icons.send),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
