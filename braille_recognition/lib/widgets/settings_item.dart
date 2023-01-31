import 'dart:developer';

import 'package:braille_recognition/widgets/ontap_scale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';

class SettingsItem extends StatefulWidget {
  SettingsItem(
      {super.key,
      required this.icon,
      required this.title,
      required this.onTap,
      this.isSwitch = false});

  String title;
  String icon;
  bool isSwitch;
  Function onTap;

  @override
  State<SettingsItem> createState() => _SettingsItemState();
}

class _SettingsItemState extends State<SettingsItem> {
  @override
  Widget build(BuildContext context) {
    return OnTapScaleAndFade(
      onTap: (){
        widget.onTap();
      },
      lowerBound: 0.95,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            SvgPicture.asset(
              widget.icon,
              width: 24,
              height: 24,
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Text(
                widget.title,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black.withOpacity(0.6),
                    ),
              ),
            ),
            widget.isSwitch
                ? CupertinoSwitch(
                    value: true,
                    onChanged: (v) {
                      log(v.toString());
                    },
                    activeColor: Color(0xFF1DB2EC),
                  )
                : SvgPicture.asset(
                    "icons/arrow_right.svg",
                    color: Colors.black.withOpacity(0.6),
                    width: 24,
                    height: 24,
                  ),
          ],
        ),
      ),
    );
  }
}
