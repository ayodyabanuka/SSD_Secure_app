import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ssd_secure_app/Providers/AuthProvider.dart';
import 'package:ssd_secure_app/Utils/appcolors.dart';
import 'package:ssd_secure_app/Widgets/CustomAppbar.dart';
import 'package:ssd_secure_app/Widgets/CustomButton.dart';
import 'package:ssd_secure_app/Widgets/CustomTextField.dart';
import 'package:ssd_secure_app/Widgets/snack_bar.dart';
import 'package:ssd_secure_app/constants.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

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
                const SizedBox(height: 20),
                Customtextfield(
                  lable: "Password",
                  controller: password,
                  isPassword: true,
                ),
                Customtextfield(lable: "Password", controller: password, isPassword: true)
              ],
            ),
          ),
          CustomButton(
            function: () {
              if (email.value.text.isNotEmpty && password.value.text.isNotEmpty) {
                Provider.of<AuthProvider>(context, listen: false).userLogin(context, email.value.text, password.value.text);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(Constants.fieldEmpty));
              }
            },
            text: "Next",
          )
        ],
      ),
    );
  }
}
