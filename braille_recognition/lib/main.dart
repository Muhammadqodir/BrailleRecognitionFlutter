import 'package:braille_recognition/widgets/circle_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset("images/onboarding_0.png"),
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                  child: Image.asset("images/meeting.png"),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: Container(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            CircularPercentIndicator(
              radius: 39,
              percent: 0.25,
              linearGradient: LinearGradient(colors: [
                Color(0xFFB3EAFF),
                Color(0xFF4AB7E0),
                Color(0xFF0AB0EF),
              ]),
              lineWidth: 3,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              circularStrokeCap: CircularStrokeCap.round,
            ),
            CircleButton(size: 60)
          ],
        ),
      ),
    );
  }
}
