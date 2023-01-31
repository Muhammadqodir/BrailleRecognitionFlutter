import 'package:braille_recognition/language.dart';
import 'package:braille_recognition/widgets/custom_button.dart';
import 'package:braille_recognition/widgets/history_item.dart';
import 'package:braille_recognition/widgets/ontap_scale.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';

class ContentHistory extends StatefulWidget {
  const ContentHistory({super.key});

  @override
  State<ContentHistory> createState() => _ContentHistoryState();
}

class _ContentHistoryState extends State<ContentHistory> {
  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  void getData() async {
    if(!await Hive.isBoxOpen("history")){
      await Hive.openBox("history");
    }
    var box = await Hive.box('history');
    for (var i = 0; i < box.length; i++) {
      print(box.getAt(i));
    }
  }

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
                  onTap: () {
                    getData();
                  },
                  child: SvgPicture.asset("images/notification.svg"),
                  width: 24,
                  height: 24,
                )
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(24),
              children: [
                HistoryItem(
                  result: "result",
                  imageUrl:
                      "https://angelina-reader.ru/static/data/results/1db592d18ac94e8ba592f017a6df2a28.marked.jpg",
                  isFav: true,
                  language: 2,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
