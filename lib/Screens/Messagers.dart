import 'package:flutter/material.dart';
import 'package:ssd_secure_app/Utils/appcolors.dart';

class Messages extends StatefulWidget {
  Messages({Key key}) : super(key: key);

  @override
  State<Messages> createState() => _MessagesState();
}

TextEditingController addtext = TextEditingController();

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bcColor,
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: bcColor,
        title: const Text(
          "Messages",
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
                return ListTile(
                  title: Text('Message $index'),
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
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 0, 0, 0), width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      border: const OutlineInputBorder(),
                    ),
                    controller: addtext,
                  ),
                ),
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
