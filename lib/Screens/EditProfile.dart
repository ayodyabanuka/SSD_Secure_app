import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:ssd_secure_app/Utils/appcolors.dart';
import 'package:ssd_secure_app/Utils/textSize.dart';
import 'package:ssd_secure_app/Widgets/CustomButton.dart';
import 'package:ssd_secure_app/Widgets/CustomTextField.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

const List<String> worker = <String>[
  'Worker',
  'Manager',
];

class _EditProfileState extends State<EditProfile> {
  TextEditingController email = TextEditingController();
  TextEditingController adderss = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController postCode = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String dropdownValue = worker.first;
    return Scaffold(
      backgroundColor: bcColor,
      appBar: AppBar(
        toolbarHeight: 110,
        backgroundColor: bcColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: const Text(
          "Register Staff",
          style: TitleStyle,
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
              lable: "Address",
              controller: adderss,
            ),
            const SizedBox(
              height: 20,
            ),
            Customtextfield(
              isPassword: false,
              lable: "City",
              controller: city,
            ),
            const SizedBox(
              height: 20,
            ),
            Customtextfield(
              isPassword: false,
              lable: "Post Code",
              controller: postCode,
            ),
            const SizedBox(
              height: 20,
            ),
            Customtextfield(
              isPassword: false,
              lable: "Phone Number",
              controller: phoneNumber,
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 30,
            ),
            CustomButton(
              function: () {},
              text: "Update",
            )
          ],
        ),
      ),
    );
  }
}
