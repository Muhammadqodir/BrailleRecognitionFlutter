import 'dart:developer';
import 'dart:io';

import 'package:braille_recognition/pages/image_result.dart';
import 'package:braille_recognition/pages/image_translation.dart';
import 'package:braille_recognition/pages/main_page.dart';
import 'package:braille_recognition/pages/onboarding.dart';
import 'package:braille_recognition/pages/scan_page.dart';
import 'package:braille_recognition/themes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Braille Recognition',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      home: const MyHomePage(title: 'Braille Recognition'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return ImageTranslationPage(image: File(""));
  }
}
