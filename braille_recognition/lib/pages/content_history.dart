import 'package:braille_recognition/widgets/custom_button.dart';
import 'package:braille_recognition/widgets/ontap_scale.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContentHistory extends StatefulWidget {
  const ContentHistory({super.key});

  @override
  State<ContentHistory> createState() => _ContentHistoryState();
}

class _ContentHistoryState extends State<ContentHistory> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(24),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Favorites",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                MyButton(
                  onTap: () {},
                  child: SvgPicture.asset("images/notification.svg"),
                  width: 24,
                  height: 24,
                )
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.all(24),
                  child: Text("Favs"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
