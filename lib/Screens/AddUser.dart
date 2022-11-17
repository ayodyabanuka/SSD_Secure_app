import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ssd_secure_app/Providers/AuthProvider.dart';
import 'package:ssd_secure_app/Utils/appcolors.dart';
import 'package:ssd_secure_app/Utils/textSize.dart';
import 'package:ssd_secure_app/Widgets/CustomButton.dart';
import 'package:ssd_secure_app/Widgets/CustomTextField.dart';
import 'package:ssd_secure_app/Widgets/snack_bar.dart';
import 'package:ssd_secure_app/constants.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

const List<String> worker = <String>[
  'worker',
  'manager',
];

class _AddUserState extends State<AddUser> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = worker.first;
  }

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
          "Create User",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Customtextfield(
              isPassword: false,
              lable: "Username",
              controller: username,
            ),
            const SizedBox(
              height: 20,
            ),
            Customtextfield(
              isPassword: false,
              lable: "Email",
              controller: email,
            ),
            const SizedBox(
              height: 20,
            ),
            Customtextfield(
              isPassword: false,
              lable: "Password",
              controller: password,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: const [
                  Text("Staff Type"),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Center(
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  hint: Row(
                    children: const [
                      Icon(
                        Icons.list,
                        size: 16,
                        color: Colors.yellow,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: Text(
                          'Select Item',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.yellow,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  items: worker
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                      .toList(),
                  value: dropdownValue,
                  onChanged: (value) {
                    setState(() {
                      dropdownValue = value as String;
                    });
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios_outlined,
                  ),
                  iconSize: 14,
                  iconEnabledColor: apppurple,
                  iconDisabledColor: apppurple,
                  buttonHeight: 50,
                  buttonWidth: 300,
                  buttonPadding: const EdgeInsets.only(left: 25, right: 25),
                  buttonDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.black26,
                    ),
                    color: bcColor,
                  ),
                  buttonElevation: 2,
                  itemHeight: 40,
                  itemPadding: const EdgeInsets.only(left: 25, right: 25),
                  dropdownMaxHeight: 200,
                  dropdownWidth: 300,
                  dropdownPadding: null,
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  dropdownElevation: 8,
                  scrollbarRadius: const Radius.circular(5),
                  scrollbarThickness: 6,
                  scrollbarAlwaysShow: true,
                  offset: const Offset(0, 0),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            CustomButton(
              function: () {
                if (username.text.isNotEmpty || email.text.isNotEmpty || password.text.isNotEmpty) {
                  Provider.of<AuthProvider>(context, listen: false).createUser(context, username.text, email.text, password.text, dropdownValue);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(Constants.fieldEmpty));
                }
              },
              text: "Register",
            )
          ],
        ),
      ),
    );
  }
}
