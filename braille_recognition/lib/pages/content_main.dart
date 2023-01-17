import 'dart:developer';
import 'dart:io';

import 'package:braille_recognition/pages/image_result.dart';
import 'package:braille_recognition/pages/image_translation.dart';
import 'package:braille_recognition/widgets/bottom_navigation.dart';
import 'package:braille_recognition/widgets/custom_button.dart';
import 'package:braille_recognition/widgets/ontap_scale.dart';
import 'package:edge_detection/edge_detection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ContentMain extends StatefulWidget {
  const ContentMain({super.key});

  @override
  State<ContentMain> createState() => _ContentMainState();
}

class _ContentMainState extends State<ContentMain> {
  String? imagePath;
  void runCamera() async {
    log("test");
    await Permission.camera.request();

    bool isCameraGranted = await Permission.camera.request().isGranted;

    // if (!isCameraGranted) {
    //     return;
    // }

    imagePath = join((await getApplicationSupportDirectory()).path,
        "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");

    try {
      bool success = await EdgeDetection.detectEdge(
        imagePath ?? "",
        canUseGallery: false,
        androidScanTitle: 'Scanning', // use custom localizations for android
        androidCropTitle: 'Crop',
        androidCropBlackWhiteTitle: 'Crop',
        androidCropReset: 'Reset',
      );
      if (success) {
        Navigator.push(
          this.context,
          CupertinoPageRoute(
            builder: ((context) =>
                ImageTranslationPage(image: File(imagePath ?? ''))),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  void runGallery() async {
    log("runGallery");
    await Permission.camera.request();

    bool isCameraGranted = await Permission.camera.request().isGranted;

    // if (!isCameraGranted) {
    //     return;
    // }

    imagePath = join((await getApplicationSupportDirectory()).path,
        "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");

    try {
      bool success = await EdgeDetection.detectEdgeFromGallery(
        imagePath ?? "",
        androidCropTitle: 'Crop',
        androidCropBlackWhiteTitle: 'Crop',
        androidCropReset: 'Reset',
      );
      if (success) {
        Navigator.push(
          this.context,
          CupertinoPageRoute(
            builder: ((context) =>
                ImageTranslationPage(image: File(imagePath ?? ''))),
          ),
        );
      }
    } catch (e) {
      print(e);
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
                    "Braille Recognition",
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
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(24),
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
                            Expanded(
                              child: Text(
                                "Braille",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.titleMedium,
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
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
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
                        child: Row(
                          children: [
                            Expanded(
                              child: OnTapScaleAndFade(
                                onTap: runCamera,
                                child: Column(
                                  children: [
                                    SvgPicture.asset("icons/camera.svg"),
                                    Text(
                                      "Camera",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: OnTapScaleAndFade(
                                onTap: runGallery,
                                child: Column(
                                  children: [
                                    SvgPicture.asset("icons/import.svg"),
                                    Text(
                                      "Import",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: OnTapScaleAndFade(
                                child: Column(
                                  children: [
                                    SvgPicture.asset("icons/edit.svg"),
                                    Text(
                                      "Keyboard",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                  ],
                                ),
                                onTap: () {},
                              ),
                            ),
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
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "History",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontFamily: "PoppinBold"),
                            ),
                          ),
                          CupertinoButton(
                            child: Opacity(
                              opacity: 0.6,
                              child: Text(
                                "See more",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      OnTapScaleAndFade(
                        onTap: () {},
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 4,
                                blurRadius: 20,
                                offset: const Offset(
                                    0, 10), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Hello",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "Hello",
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
                              SvgPicture.asset(
                                "icons/star.svg",
                                height: 24,
                                width: 24,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      OnTapScaleAndFade(
                        onTap: () {},
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 4,
                                blurRadius: 20,
                                offset:
                                    Offset(0, 10), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Translate",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "Translate",
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
                              SvgPicture.asset(
                                "icons/star.svg",
                                height: 24,
                                width: 24,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
