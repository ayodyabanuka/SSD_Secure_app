import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ssd_secure_app/Models/UserModel.dart';
import 'package:ssd_secure_app/Providers/AuthProvider.dart';
import 'package:ssd_secure_app/Utils/appcolors.dart';
import 'package:ssd_secure_app/Widgets/CustomButton.dart';
import 'package:ssd_secure_app/Widgets/CustomTextField.dart';
import 'package:ssd_secure_app/Widgets/snack_bar.dart';
import 'package:ssd_secure_app/constants.dart';

class EditProfile extends StatefulWidget {
  final User user;

  const EditProfile({Key key, this.user}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  User user;
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    user = widget.user;
    username.text = user.username;
    email.text = user.email;
    super.initState();
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
          "Edit Profile",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Customtextfield(
                isPassword: false,
                lable: "Username",
                controller: username,
              ),
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
              isPassword: true,
              lable: "Password",
              controller: password,
            ),
            const SizedBox(height: 30),
            CustomButton(
              function: () {
                if (username.text.isEmpty || email.text.isEmpty || password.text.isEmpty) {
                  Provider.of<AuthProvider>(context, listen: false).updateUser(context, username.text, email.text, password.text);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(Constants.fieldEmpty));
                }
              },
              text: "Update",
            )
          ],
        ),
      ),
    );
  }
}
