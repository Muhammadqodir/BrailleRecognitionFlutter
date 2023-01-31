import 'package:braille_recognition/language.dart';
import 'package:braille_recognition/widgets/custom_button.dart';
import 'package:braille_recognition/widgets/history_item.dart';
import 'package:braille_recognition/widgets/ontap_scale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:sqflite/sqflite.dart';

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

  List<HistoryModel> items = [];

  void getData() async {
    final db = await openDatabase('${await getDatabasesPath()}/history.db');

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query(
      'history', where: 'isFav = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [true],
    );
    items = List.generate(maps.length, (i) {
      return HistoryModel(
        maps[i]['id'],
        maps[i]['res'],
        maps[i]['res_url'],
        maps[i]['lang'],
        maps[i]['isFav'] == 1,
      );
    });

    setState(() {});
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
                // MyButton(
                //   onTap: () {
                //     getData();
                //   },
                //   child: SvgPicture.asset("images/notification.svg"),
                //   width: 24,
                //   height: 24,
                // )
              ],
            ),
          ),
          Expanded(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: [
                CupertinoSliverRefreshControl(
                  onRefresh: () async {
                    getData();
                  },
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: items.length > 0
                            ? Column(
                                children: items
                                    .map((e) => Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 24),
                                          child: HistoryItem(
                                            id: e.id,
                                            result: e.result,
                                            imageUrl: e.result_url,
                                            language: e.lang,
                                            isFav: e.isFav,
                                          ),
                                        ))
                                    .toList(),
                              )
                            : Center(
                                child: SvgPicture.asset(
                                  "images/404.svg",
                                  width: 200,
                                ),
                              )),
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
