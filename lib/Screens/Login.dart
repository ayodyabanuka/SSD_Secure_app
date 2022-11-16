import 'package:flutter/material.dart';
import 'package:ssd_secure_app/Screens/Home.dart';
import 'package:ssd_secure_app/Utils/appcolors.dart';
import 'package:ssd_secure_app/Widgets/CustomAppbar.dart';
import 'package:ssd_secure_app/Widgets/CustomButton.dart';
import 'package:ssd_secure_app/Widgets/CustomTextField.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bcColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: apppurple,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomAppBar(
            title: "Login",
            subtitle: "Please login here!",
            isleading: false,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Customtextfield(
                  lable: "Email",
                  controller: email,
                  isPassword: false,
                ),
                const SizedBox(
                  height: 20,
                ),
                Customtextfield(
                    lable: "Password", controller: password, isPassword: true)
              ],
            ),
          ),
          CustomButton(
            function: () {
              if (email.value.text.isNotEmpty &&
                  password.value.text.isNotEmpty) {
                if (email.text == "admin") {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Home(
                                admin: true,
                                worker: false,
                                manager: false,
                              )),
                      (route) => false);
                }
                if (email.text == "worker") {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Home(
                                admin: false,
                                worker: true,
                                manager: false,
                              )),
                      (route) => false);
                }
                if (email.text == "manager") {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Home(
                                admin: false,
                                worker: false,
                                manager: true,
                              )),
                      (route) => false);
                }
              } else {
                null;
              }
            },
            text: "Next",
          )
        ],
      ),
    );
  }
}
