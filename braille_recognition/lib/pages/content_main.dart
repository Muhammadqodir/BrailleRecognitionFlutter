import 'dart:developer';
import 'dart:io';

import 'package:braille_recognition/language.dart';
import 'package:braille_recognition/pages/image_result.dart';
import 'package:braille_recognition/pages/image_translation.dart';
import 'package:braille_recognition/widgets/bottom_navigation.dart';
import 'package:braille_recognition/widgets/card.dart';
import 'package:braille_recognition/widgets/custom_button.dart';
import 'package:braille_recognition/widgets/history_item.dart';
import 'package:braille_recognition/widgets/ontap_scale.dart';
import 'package:edge_detection/edge_detection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

const double _kItemExtent = 32.0;

class ContentMain extends StatefulWidget {
  const ContentMain({super.key});

  @override
  State<ContentMain> createState() => _ContentMainState();
}

class _ContentMainState extends State<ContentMain> {
  _ContentMainState();
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
            builder: ((context) => ImageTranslationPage(
                  image: File(imagePath ?? ''),
                  lang_code: selectedCourse,
                )),
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
            builder: ((context) => ImageTranslationPage(
                  image: File(imagePath ?? ''),
                  lang_code: selectedCourse,
                )),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  int selectedCourse = 0;

  List<Language> langs = [
    Language("GR1 English", "EN"),
    Language("GR2 English", "EN2"),
    Language("Portuguese", "EN"),
    Language("Russian", "RU"),
    Language("Uzbek", "UZ"),
    Language("Uzbek(Latin)", "UZL"),
    Language("Deutsch", "DE"),
    Language("Greek", "GR"),
    Language("Latvian", "LV"),
    Language("Polish", "PL"),
  ];
  void showSelectLangDialog() {
    FixedExtentScrollController extentScrollController =
        FixedExtentScrollController(initialItem: selectedCourse);
    showCupertinoModalPopup<void>(
      context: this.context,
      builder: (BuildContext context) => Container(
        height: 250,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              SizedBox(
                height: 150,
                child: CupertinoPicker(
                  scrollController: extentScrollController,
                  magnification: 1.22,
                  squeeze: 1.2,
                  useMagnifier: false,
                  looping: false,
                  itemExtent: _kItemExtent,
                  // This is called when selected item is changed.
                  onSelectedItemChanged: (int selectedItem) {
                    SystemSound.play(SystemSoundType.click);
                    HapticFeedback.mediumImpact();
                  },
                  children: List<Widget>.generate(langs.length, (int index) {
                    return Center(
                      child: Text(
                        langs[index].title,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    );
                  }),
                ),
              ),
              CupertinoButton(
                child: Text(
                  "Выбрать",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                onPressed: () {
                  SharedPreferences.getInstance().then((value) {
                    value.setDouble("defaultLang", extentScrollController.selectedItem.toDouble());
                  });

                  setState(() {
                    selectedCourse = extentScrollController.selectedItem;
                  });
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    setDefaultLang();
    super.initState();
  }

  void setDefaultLang() async{
    final prefs = await SharedPreferences.getInstance();
    int defaultLang = (prefs.getDouble("defaultLang") ?? 0).round();
    setState(() {
      selectedCourse = defaultLang;
    });
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
                        child: OnTapScaleAndFade(
                          onTap: showSelectLangDialog,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Braille",
                                  textAlign: TextAlign.center,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                              SvgPicture.asset(
                                "icons/swap.svg",
                                height: 28,
                                width: 28,
                              ),
                              Expanded(
                                child: Text(
                                  langs[selectedCourse].title,
                                  textAlign: TextAlign.center,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                            ],
                          ),
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
                      HistoryItem(
                        result: "Braille Recongition",
                        imageUrl:
                            "https://angelina-reader.ru/static/data/results/1db592d18ac94e8ba592f017a6df2a28.marked.jpg",
                        isFav: false,
                        language: Language("Russian", "RU"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      HistoryItem(
                        result: "ответ: Илья бежал со скоростью 15 км/ч",
                        imageUrl:
                            "https://angelina-reader.ru/static/data/results/fce21c39b91749589df807fd81377a0d.marked.jpg",
                        isFav: false,
                        language: Language("Russian", "RU"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      HistoryItem(
                        result: "1)  300:5=60(с.); \n2)  300:15=20(с.);",
                        imageUrl:
                            "https://angelina-reader.ru/static/data/results/8395d4db3ff746e381dc2fd5cc65189d.marked.jpg",
                        isFav: false,
                        language: Language("Russian", "RU"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // HistoryItem(
                      //   result: "1)  300:5=60(с.);\n2)  300:15=20 (с.);\nответ: Илья бежал со скоростью 15 км/ч.",
                      //   imageUrl:
                      //       "https://angelina-reader.ru/static/data/results/fce21c39b91749589df807fd81377a0d.marked.jpg",
                      //   isFav: false,
                      // ),
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
