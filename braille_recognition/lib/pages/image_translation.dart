import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:braille_recognition/api.dart';
import 'package:braille_recognition/language.dart';
import 'package:braille_recognition/pages/image_result.dart';
import 'package:braille_recognition/widgets/custom_button.dart';
import 'package:braille_recognition/widgets/scanner_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:measured_size/measured_size.dart';

class ImageTranslationPage extends StatefulWidget {
  ImageTranslationPage({Key? key, required this.image}) : super(key: key);

  File image;

  List<Language> langs = [
    Language("GR1 English", "EN"),
    Language("GR2 English", "EN2"),
    Language("Russian", "RU"),
    Language("Deutsch", "DE"),
    Language("Greek", "GR"),
    Language("Latvian", "LV"),
    Language("Polish", "PL"),
    Language("Uzbek", "UZ"),
    Language("Uzbek(Latin)", "UZL"),
  ];

  @override
  State<ImageTranslationPage> createState() => _ImageTranslationPageState();
}

class _ImageTranslationPageState extends State<ImageTranslationPage>
    with SingleTickerProviderStateMixin {
  bool _animationStopped = false;
  late AnimationController _animationController;

  double image_height = 50;
  double percent = 0;

  bool langSelected = false;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animateScanAnimation(true);
      } else if (status == AnimationStatus.dismissed) {
        animateScanAnimation(false);
      }
    });
    super.initState();
  }

  void animateScanAnimation(bool reverse) {
    if (reverse) {
      _animationController.reverse(from: 1.0);
    } else {
      _animationController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  GlobalKey key = GlobalKey();

  void translate(String lang) {
    final RenderBox renderBox =
        key.currentContext?.findRenderObject() as RenderBox;
    setState(() {
      image_height = renderBox.size.height + 60;
      langSelected = true;
    });
    animateScanAnimation(false);
    Translator.translate(widget.image, lang, (bytes, totalBytes) {
      setState(() {
        percent = bytes/totalBytes;
        log(percent.toString());
      });
    }, (res, image) {
        log(res);
        log(image);
      Navigator.pushReplacement(context, CupertinoPageRoute(builder: ((context) {
        return ImageResultPage(image_url: image, original: widget.image, result: res,);
      })));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24),
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
                        const SizedBox(
                          width: 24,
                        ),
                        // MyButton(
                        //   onTap: () {},
                        //   child: SvgPicture.asset("images/notification.svg"),
                        //   width: 24,
                        //   height: 24,
                        // )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Hero(
                          tag: 'image',
                          child: Container(
                            margin: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                  offset: const Offset(
                                      0, 4), // changes position of shadow
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12),
                              ),
                              child: Stack(
                                children: [
                                  MeasuredSize(
                                    onChange: ((size) {
                                      log("Size changed");
                                    }),
                                    child: Container(
                                      key: key,
                                      child: Image.file(
                                        widget.image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  ScannerAnimation(
                                    _animationStopped,
                                    image_height,
                                    animation: _animationController,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Stack(
                          children: [
                            AnimatedOpacity(
                              opacity: langSelected ? 0 : 1,
                              duration: const Duration(milliseconds: 200),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Select language:",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  const SizedBox(
                                    height: 12,
                                    width: double.infinity,
                                  ),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    runAlignment: WrapAlignment.center,
                                    alignment: WrapAlignment.center,
                                    children: widget.langs
                                        .map(
                                          (e) => CupertinoButton(
                                            child: Text(e.title),
                                            color: const Color(0xFF26A6D6),
                                            padding: const EdgeInsets.all(12),
                                            onPressed: () => translate(e.code),
                                          ),
                                        )
                                        .toList(),
                                  )
                                ],
                              ),
                            ),
                            AnimatedOpacity(
                              opacity: langSelected ? 1 : 0,
                              duration: const Duration(milliseconds: 200),
                              child: Column(
                                children: [
                                  Text(
                                    "Analyzing image...",
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  const SizedBox(
                                    height: 12,
                                    width: double.infinity,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24),
                                    child: LinearProgressIndicator(
                                      color: const Color(0xFF26A6D6),
                                      backgroundColor: const Color(0xFFB2E4F8),
                                      value: percent,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
