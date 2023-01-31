import 'package:braille_recognition/language.dart';
import 'package:braille_recognition/pages/image_result.dart';
import 'package:braille_recognition/pages/image_viewer_page.dart';
import 'package:braille_recognition/widgets/ontap_scale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:sqflite/sqflite.dart';

class HistoryItem extends StatefulWidget {
  HistoryItem(
      {super.key,
      required this.id,
      required this.result,
      required this.imageUrl,
      required this.language,
      required this.isFav});
  int id;
  String result;
  String imageUrl;
  int language;
  bool isFav;

  @override
  State<HistoryItem> createState() => _HistoryItemState(isFav);
}

class _HistoryItemState extends State<HistoryItem> {
  bool isFav = false;

  _HistoryItemState(this.isFav);

  void toggleFav() {
    setState(() {
      isFav = !isFav;
    });
    updateDog(HistoryModel(
      widget.id,
      widget.result,
      widget.imageUrl,
      widget.language,
      isFav,
    ));
  }

  void updateDog(HistoryModel dog) async {
    // Get a reference to the database.
    final db = await openDatabase('${await getDatabasesPath()}/history.db');
    ;

    // Update the given Dog.
    await db.update(
      'history',
      dog.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [dog.id],
    );
  }

  @override
  Widget build(BuildContext context) {
    return OnTapScaleAndFade(
      lowerBound: 0.90,
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: ((context) {
              return ImageResultPage(
                image_url: widget.imageUrl,
                original: null,
                result: widget.result,
                lang: widget.language,
              );
            }),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 4,
              blurRadius: 20,
              offset: const Offset(0, 10), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            OnTapScaleAndFade(
              onTap: () {
                // Translator.translate(widget.image);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) {
                      return ImageViewer(
                        imageProvider: NetworkImage(
                          widget.imageUrl,
                        ),
                      );
                    }),
                  ),
                );
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 4), // changes position of shadow
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                  child: Image(
                    image: NetworkImage(widget.imageUrl),
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.result.substring(widget.result.indexOf("\n") + 1),
                    maxLines: 4,
                    overflow: TextOverflow.fade,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    widget.result
                        .substring(widget.result.indexOf("\n") + 1)
                        .replaceAll("=", " "),
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontFamily: "Braille"),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
            OnTapScaleAndFade(
              onTap: toggleFav,
              child: Opacity(
                opacity: 0.7,
                child: SvgPicture.asset(
                  isFav ? "icons/star_gradient.svg" : "icons/star_outline.svg",
                  height: isFav ? 23 : 22,
                  width: isFav ? 23 : 22,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HistoryModel {
  String result;
  String result_url;
  int lang;
  bool isFav;
  int id;

  HistoryModel(this.id, this.result, this.result_url, this.lang, this.isFav);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'res': result,
      'res_url': result_url,
      'lang': lang,
      'isFav': isFav,
    };
  }

  Map<String, dynamic> toMapNew() {
    return {
      'res': result,
      'res_url': result_url,
      'lang': lang,
      'isFav': isFav,
    };
  }
}
