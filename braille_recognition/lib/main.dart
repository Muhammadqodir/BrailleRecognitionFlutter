import 'dart:developer';
import 'dart:io';

import 'package:braille_recognition/pages/image_result.dart';
import 'package:braille_recognition/pages/image_translation.dart';
import 'package:braille_recognition/pages/main_page.dart';
import 'package:braille_recognition/pages/onboarding.dart';
import 'package:braille_recognition/pages/scan_page.dart';
import 'package:braille_recognition/themes.dart';
import 'package:braille_recognition/widgets/history_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light) // Or Brightness.dark
      );

  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationSupportDirectory();
  final database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'history.db'),
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        'CREATE TABLE history(id INTEGER PRIMARY KEY, res TEXT, res_url TEXT, lang INTEGER, isFav BOOLEAN)',
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );

  SharedPreferences.getInstance().then(
    (value) {
      runApp(MyApp(
        isFirstOpen: value.getBool("isFirstOpen") ?? true,
      ));
    },
  );
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
  MyHomePage({super.key, required this.title, this.isFirstOpen = true});

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
