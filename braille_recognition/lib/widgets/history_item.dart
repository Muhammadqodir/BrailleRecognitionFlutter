import 'package:braille_recognition/pages/image_result.dart';
import 'package:braille_recognition/pages/image_viewer_page.dart';
import 'package:braille_recognition/widgets/ontap_scale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';

class HistoryItem extends StatefulWidget {
  HistoryItem(
      {super.key,
      required this.result,
      required this.imageUrl,
      required this.isFav});

  String result;
  String imageUrl;
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
                    widget.result,
                    maxLines: 4,
                    overflow: TextOverflow.fade,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    widget.result.replaceAll("=", " "),
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
