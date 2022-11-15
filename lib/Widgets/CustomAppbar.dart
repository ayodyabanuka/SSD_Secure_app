import 'package:flutter/material.dart';
import 'package:ssd_secure_app/Utils/appcolors.dart';
import 'package:ssd_secure_app/Utils/textSize.dart';
import 'package:ssd_secure_app/Widgets/CustomTextField.dart';

class CustomAppBar extends StatefulWidget {
  bool isleading;
  String title, subtitle;
  CustomAppBar({Key key, this.isleading, this.title, this.subtitle})
      : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 40),
      height: 160,
      decoration: const BoxDecoration(color: bcColor),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: widget.isleading
            ? MainAxisAlignment.start
            : MainAxisAlignment.center,
        children: [
          Visibility(
              visible: widget.isleading,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back))),
          const SizedBox(
            width: 10,
          ),
          Column(
            children: [
              Text(
                widget.title,
                style: TitleStyle,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.subtitle,
                style: SubTitleStyle,
              ),
            ],
          )
        ],
      ),
    );
  }
}
