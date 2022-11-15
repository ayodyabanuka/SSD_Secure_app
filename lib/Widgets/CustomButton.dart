import 'package:flutter/material.dart';
import 'package:ssd_secure_app/Utils/appcolors.dart';

class CustomButton extends StatefulWidget {
  Function function;
  String text;
  CustomButton({Key key, this.function, this.text}) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
        onTap: widget.function,
        child: Container(
          width: size.width,
          margin: const EdgeInsets.only(bottom: 70, left: 25, right: 25),
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
              color: apppurple, borderRadius: BorderRadius.circular(5.0)),
          child: Center(
              child: Text(
            widget.text,
            style: const TextStyle(color: Colors.black, fontSize: 16),
          )),
        ));
  }
}
