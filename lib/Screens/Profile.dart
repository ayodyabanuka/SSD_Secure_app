import 'package:flutter/material.dart';
import 'package:ssd_secure_app/Models/UserModel.dart';
import 'package:ssd_secure_app/Screens/EditProfile.dart';
import 'package:ssd_secure_app/Utils/appcolors.dart';
import 'package:ssd_secure_app/Widgets/CustomButton.dart';
import 'package:ssd_secure_app/sharedPrefs.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User user = User(id: '', email: '', type: '', username: '');
  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  getUserDetails() async {
    User userPrefs = User.fromJson(await SharedPref.readObject('User'));
    setState(() {
      user = userPrefs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: bcColor,
        title: const Text(
          "User profile",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Username",
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            const SizedBox(height: 5),
            Text(
              user.username,
              style: const TextStyle(color: Colors.black, fontSize: 20),
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              "Email",
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            const SizedBox(height: 5),
            Text(
              user.email,
              style: const TextStyle(color: Colors.black, fontSize: 20),
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              "User Role",
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            const SizedBox(height: 5),
            Text(
              user.type,
              style: const TextStyle(color: Colors.black, fontSize: 20),
            ),
            const SizedBox(
              height: 25,
            ),
            const SizedBox(
              height: 65,
            ),
            CustomButton(
              function: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfile(
                      user: user,
                    ),
                  ),
                );
              },
              text: "Edit",
            )
          ],
        ),
      )),
    );
  }
}
