import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:braille_recognition/api.dart';
import 'package:braille_recognition/pages/image_viewer_page.dart';
import 'package:braille_recognition/widgets/custom_button.dart';
import 'package:braille_recognition/widgets/ontap_scale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageResultPage extends StatefulWidget {
  ImageResultPage(
      {Key? key,
      required this.image_url,
      required this.original,
      required this.result})
      : super(key: key);

  String image_url;
  File original;
  String result;

  @override
  State<ImageResultPage> createState() => _ImageResultPageState();
}

class _ImageResultPageState extends State<ImageResultPage> {
  String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(24),
                  child: Row(
                    children: [
                      MyButton(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SvgPicture.asset("icons/back.svg"),
                        width: 24,
                        height: 24,
                      ),
                      Expanded(
                        child: Text(
                          "Translation",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      MyButton(
                        onTap: () {},
                        child: SvgPicture.asset(
                          "icons/share.svg",
                          color: Colors.black,
                        ),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(24),
                                  topRight: Radius.circular(24),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFFA2E7FB).withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 10,
                                    offset: const Offset(
                                        0, 4), // changes position of shadow
                                  ),
                                ],
                                color: Color(0xFFA2E7FB),
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
                                                widget.image_url,
                                              ),
                                            );
                                          }),
                                        ),
                                      );
                                    },
                                    child: Hero(
                                      tag: 'image',
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(12)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.3),
                                              spreadRadius: 1,
                                              blurRadius: 10,
                                              offset: const Offset(0,
                                                  4), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(12),
                                          ),
                                          child: FadeInImage(
                                            image:
                                                NetworkImage(widget.image_url),
                                            placeholder: FileImage(
                                              widget.original,
                                            ),
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Braille",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ),
                                  SvgPicture.asset(
                                    "icons/swap.svg",
                                    height: 28,
                                    width: 28,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Cyliric",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(24),
                                  bottomRight: Radius.circular(24),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFFD5F3FB).withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 10,
                                    offset: const Offset(
                                        0, 4), // changes position of shadow
                                  ),
                                ],
                                color: Color(0xFFD5F3FB),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.result,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(fontFamily: "Braille"),
                                  ),
                                  SizedBox(
                                    height: 24,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              "Translation",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontFamily: "PoppinBold"),
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 24, horizontal: 12),
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(24)),
                                color: const Color(0xFFD5F3FB),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFFD5F3FB).withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 10,
                                    offset: const Offset(
                                        0, 4), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.result,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      MyButton(
                                        onTap: () {},
                                        width: 20,
                                        height: 20,
                                        child: SvgPicture.asset(
                                          "icons/paper.svg",
                                          color: const Color(0xFF828282),
                                          width: 20,
                                          height: 20,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 18,
                                      ),
                                      MyButton(
                                        onTap: () {},
                                        width: 22,
                                        height: 22,
                                        child: SvgPicture.asset(
                                          "icons/sound.svg",
                                          color: Color(0xFF828282),
                                          width: 22,
                                          height: 22,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 18,
                                      ),
                                      MyButton(
                                        onTap: () {},
                                        width: 18,
                                        height: 18,
                                        child: SvgPicture.asset(
                                          "icons/star_small.svg",
                                          color: Color(0xFF828282),
                                          width: 18,
                                          height: 18,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 14,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
