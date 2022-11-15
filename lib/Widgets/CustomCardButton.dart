import 'package:flutter/material.dart';

class CustomCardButton extends StatefulWidget {
  Function function;
  IconData icon;
  String text;
  CustomCardButton({Key key, this.function, this.icon, this.text})
      : super(key: key);

  @override
  State<CustomCardButton> createState() => _CustomCardButtonState();
}

class _CustomCardButtonState extends State<CustomCardButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.function,
      child: Container(
        padding: const EdgeInsets.all(30.0),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              offset: const Offset(1, 1),
              blurRadius: 30,
              spreadRadius: 0,
              color: Colors.grey.withOpacity(0.3)),
        ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              widget.icon,
              color: Colors.black,
              size: 36,
            ),
            Text(
              widget.text,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
