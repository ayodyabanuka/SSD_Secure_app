import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ssd_secure_app/Screens/AddUser.dart';
import 'package:ssd_secure_app/Screens/Files.dart';
import 'package:ssd_secure_app/Screens/Messagers.dart';
import 'package:ssd_secure_app/Screens/Profile.dart';
import 'package:ssd_secure_app/Utils/appcolors.dart';
import 'package:ssd_secure_app/Widgets/CustomAppbar.dart';
import 'package:ssd_secure_app/Widgets/CustomCardButton.dart';

class Home extends StatefulWidget {
  bool admin, worker, manager;
  Home({Key key, this.admin, this.manager, this.worker}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bcColor,
      appBar: AppBar(
        backgroundColor: apppurple,
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: Column(
        children: [
          CustomAppBar(
            isleading: false,
            title: "Home",
            subtitle: "",
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                CustomCardButton(
                  text: "Messages",
                  icon: Icons.message,
                  function: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Messages()));
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomCardButton(
                  text: "Files",
                  icon: Icons.file_copy,
                  function: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Files()));
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomCardButton(
                  text: "Create Account",
                  icon: Icons.account_box,
                  function: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddUser()));
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomCardButton(
                  text: "Profile",
                  icon: Icons.person,
                  function: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Profile()));
                  },
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
