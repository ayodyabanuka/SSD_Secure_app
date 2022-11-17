import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ssd_secure_app/Models/UserModel.dart';
import 'package:ssd_secure_app/Screens/AddUser.dart';
import 'package:ssd_secure_app/Screens/Files.dart';
import 'package:ssd_secure_app/Screens/Login.dart';
import 'package:ssd_secure_app/Screens/Messagers.dart';
import 'package:ssd_secure_app/Screens/Profile.dart';
import 'package:ssd_secure_app/Utils/appcolors.dart';
import 'package:ssd_secure_app/Widgets/CustomAppbar.dart';
import 'package:ssd_secure_app/Widgets/CustomCardButton.dart';
import 'package:ssd_secure_app/sharedPrefs.dart';

class Home extends StatefulWidget {
  bool admin, worker, manager;
  Home({Key key, this.admin, this.manager, this.worker}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String userRole;
  @override
  Future<void> initState() {
    userRole = 'worker';
    getUserRole();
    super.initState();
  }

  getUserRole() async {
    User user = User.fromJson(await SharedPref.readObject('User'));
    setState(() {
      userRole = user.type;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bcColor,
      appBar: AppBar(
        backgroundColor: bcColor,
        actions: [
          IconButton(
              onPressed: () {
                Logout();
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              ))
        ],
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
                const SizedBox(height: 20),
                userRole == 'worker'
                    ? const SizedBox(height: 0)
                    : CustomCardButton(
                        text: "Files",
                        icon: Icons.file_copy,
                        function: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Files()));
                        },
                      ),
                const SizedBox(height: 20),
                userRole == 'admin'
                    ? Column(
                        children: [
                          CustomCardButton(
                            text: "Create Account",
                            icon: Icons.account_box,
                            function: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const AddUser()));
                            },
                          ),
                          const SizedBox(height: 20),
                        ],
                      )
                    : const SizedBox(height: 0),
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

  Logout() async {
    SharedPref.remove('userToken');
    SharedPref.remove('User');
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => Login()), (route) => false);
  }
}
