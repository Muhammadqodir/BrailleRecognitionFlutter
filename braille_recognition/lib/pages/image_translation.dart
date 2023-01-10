import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:braille_recognition/api.dart';
import 'package:braille_recognition/pages/image_result.dart';
import 'package:braille_recognition/widgets/custom_button.dart';
import 'package:braille_recognition/widgets/ontap_scale.dart';
import 'package:braille_recognition/widgets/scanner_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:measured_size/measured_size.dart';

class ImageTranslationPage extends StatefulWidget {
  ImageTranslationPage({Key? key, required this.image}) : super(key: key);

  File image;

  @override
  State<ImageTranslationPage> createState() => _ImageTranslationPageState();
}

class _ImageTranslationPageState extends State<ImageTranslationPage>
    with SingleTickerProviderStateMixin {
  bool _animationStopped = false;
  late AnimationController _animationController;

  double image_height = 50;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setImageHeight();
    });
    _animationController = AnimationController(
      duration: Duration(milliseconds: 2000),
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

  void setImageHeight(){
    setState(() {
      image_height = (key.currentContext?.findRenderObject() as RenderBox).size.height + 60;
      log(image_height.toString());
      animateScanAnimation(false);
    });
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'image',
                    child: Container(
                      margin: EdgeInsets.all(24),
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
                            Container(
                              key: key,
                              child: Image.network(
                                "https://previews.123rf.com/images/rglinsky/rglinsky1201/rglinsky120100188/12336990-vertical-oriented-image-of-famous-eiffel-tower-in-paris-france-.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                            ScannerAnimation(
                              _animationStopped,
                              image_height,
                              animation: _animationController,
                            )
                          ],
                        ),
                        // Image.file(
                        //   widget.image,
                        //   width: 50,
                        //   height: 50,
                        //   fit: BoxFit.cover,
                        // ),
                      ),
                    ),
                  ),
                  Text("data"),
                  CupertinoButton(
                    child: const Text("test"),
                    onPressed: () {
                      // Navigator.push(context,
                      //     CupertinoPageRoute(builder: ((context) {
                      //   return ImageResultPage(image: widget.image);
                      // })));
                      animateScanAnimation(false);
                      final RenderBox renderBox = key.currentContext?.findRenderObject() as RenderBox;
                      log(renderBox.size.height.toString());
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
