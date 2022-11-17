import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ssd_secure_app/Models/MessageModel.dart';
import 'package:ssd_secure_app/Providers/MessageProvider.dart';
import 'package:ssd_secure_app/Utils/appcolors.dart';
import 'package:ssd_secure_app/Widgets/snack_bar.dart';
import 'package:ssd_secure_app/constants.dart';

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
                future: Provider.of<MessageProvider>(context, listen: true).getMessageList(context),
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
                      itemBuilder: (BuildContext context, int index) => Dismissible(
                        key: UniqueKey(),
                        onDismissed: (direction) {
                          Provider.of<MessageProvider>(context, listen: false).deleteMessage(context, snapshot.data[index].id);
                        },
                        direction: DismissDirection.endToStart,
                        background: const Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 40,
                          ),
                        ),
                        child: GestureDetector(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                child: Text(
                                  snapshot.data[index].message,
                                  style: const TextStyle(color: Colors.black, fontSize: 15),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
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
                InkWell(
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(color: apppurple, borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.send),
                  ),
                  onTap: () {
                    if (addtext.text.isNotEmpty) {
                      Provider.of<MessageProvider>(context, listen: false).createMessage(context, addtext.text);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(Constants.fieldEmpty));
                    }
                  },
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
