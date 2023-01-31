import 'dart:developer';
import 'dart:io';

import 'package:braille_recognition/pages/image_result.dart';
import 'package:braille_recognition/pages/image_translation.dart';
import 'package:braille_recognition/pages/main_page.dart';
import 'package:braille_recognition/pages/onboarding.dart';
import 'package:braille_recognition/pages/scan_page.dart';
import 'package:braille_recognition/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light) // Or Brightness.dark
      );
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((value) {
    runApp(MyApp(isFirstOpen: value.getBool("isFirstOpen")??true,));
  },);
}

class MyApp extends StatelessWidget {
  MyApp({super.key, this.isFirstOpen = true});

  bool isFirstOpen;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Braille Recognition',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      home: MyHomePage(
        title: 'Braille Recognition',
        isFirstOpen: isFirstOpen,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title, this.isFirstOpen=true});

  final String title;
  bool isFirstOpen = true;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return widget.isFirstOpen ? OnboardingPage() : MainPage();
  }
}
