import 'package:flutter/material.dart';

class Customtextfield extends StatefulWidget {
  String lable;
  bool isPassword;
  String error;
  TextEditingController controller;
  Customtextfield(
      {Key key, this.isPassword, this.lable, this.controller, this.error})
      : super(key: key);

  @override
  State<Customtextfield> createState() => _CustomtextfieldState();
}

class _CustomtextfieldState extends State<Customtextfield> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              offset: const Offset(1, 1),
              blurRadius: 30,
              spreadRadius: 0,
              color: Colors.grey.withOpacity(0.3)),
        ],
      ),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.isPassword,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(
                color: Color.fromARGB(255, 0, 0, 0), width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: Colors.black),
          ),
          border: const OutlineInputBorder(),
          labelStyle: const TextStyle(color: Colors.black),
          labelText: widget.lable,
        ),
      ),
    );
  }
}
