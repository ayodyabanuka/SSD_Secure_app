import 'package:flutter/material.dart';
import 'package:ssd_secure_app/Screens/EditProfile.dart';
import 'package:ssd_secure_app/Utils/appcolors.dart';
import 'package:ssd_secure_app/Widgets/CustomButton.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
              "User Name",
              style: TextStyle(color: Colors.black, fontSize: 10),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "John Doe",
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
            const SizedBox(
              height: 25,
            ),
            const Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey,
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              "Address",
              style: TextStyle(color: Colors.black, fontSize: 10),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "J43A, Wellawatta ,Colombo",
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "City",
                        style: TextStyle(color: Colors.black, fontSize: 10),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Colombo",
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Post Code",
                        style: TextStyle(color: Colors.black, fontSize: 10),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "10500",
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Email",
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "johndoe@gmail.com",
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Phone Number",
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "+94 71 234 5678",
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ],
            ),
            const SizedBox(
              height: 65,
            ),
            CustomButton(
              function: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditProfile()));
              },
              text: "Edit",
            )
          ],
        ),
      )),
    );
  }
}
