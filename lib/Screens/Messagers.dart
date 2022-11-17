import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ssd_secure_app/Models/MessageModel.dart';
import 'package:ssd_secure_app/Providers/MessageProvider.dart';
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
              child: FutureBuilder<List<Message>>(
                future: Provider.of<MessageProvider>(context, listen: false).getMessageList(context),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text("Loading..."),
                    );
                  } else {
                    return ListView.separated(
                      itemCount: snapshot.data.length,
                      separatorBuilder: (BuildContext context, int index) => const Divider(
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "File Name",
                                        style: TextStyle(color: Colors.black, fontSize: 10),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '',
                                        style: const TextStyle(color: Colors.black, fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      margin: const EdgeInsets.all(5),
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(color: apppurple, borderRadius: BorderRadius.circular(12)),
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
                },
              ),
            ),
            Expanded(
                child: ListView.separated(
              itemCount: 10,
              separatorBuilder: (BuildContext context, int index) => const Divider(),
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
                  decoration: BoxDecoration(color: apppurple, borderRadius: BorderRadius.circular(12)),
                  child: const Icon(Icons.attach_file),
                ),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 1.0),
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
                  decoration: BoxDecoration(color: apppurple, borderRadius: BorderRadius.circular(12)),
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
