import 'dart:developer';
import 'dart:io';

import 'package:braille_recognition/pages/content_history.dart';
import 'package:braille_recognition/pages/content_main.dart';
import 'package:braille_recognition/pages/content_profile.dart';
import 'package:braille_recognition/pages/image_result.dart';
import 'package:braille_recognition/pages/image_translation.dart';
import 'package:braille_recognition/widgets/bottom_navigation.dart';
import 'package:braille_recognition/widgets/custom_button.dart';
import 'package:braille_recognition/widgets/fade_indexed_stack.dart';
import 'package:braille_recognition/widgets/ontap_scale.dart';
import 'package:edge_detection/edge_detection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int pageIndex = 0;

  void openPage(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeIndexedStack(
        index: pageIndex,
        children: const [
          ContentMain(),
          ContentHistory(),
          ContentProfile(),
        ],
      ),
      bottomNavigationBar: BottomNavigation(
        items: [
          Item("title", "icons/home_outline.svg", "icons/home_gradient.svg"),
          Item("title", "icons/star_outline.svg", "icons/star_gradient.svg"),
          Item("title", "icons/profile_outline.svg",
              "icons/profile_gradient.svg")
        ],
        openPage: openPage,
      ),
    );
  }
}
