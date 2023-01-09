import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:braille_recognition/api.dart';
import 'package:braille_recognition/pages/image_result.dart';
import 'package:braille_recognition/widgets/custom_button.dart';
import 'package:braille_recognition/widgets/ontap_scale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageTranslationPage extends StatefulWidget {
  ImageTranslationPage({Key? key, required this.image}) : super(key: key);

  File image;

  @override
  State<ImageTranslationPage> createState() => _ImageTranslationPageState();
}

class _ImageTranslationPageState extends State<ImageTranslationPage> {
  String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Expanded(
              child: Container(
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
                          child:
                              // Image.file(
                              //   widget.image,
                              //   width: 50,
                              //   height: 50,
                              //   fit: BoxFit.cover,
                              // ),
                              Image.network(
                            "https://media.istockphoto.com/id/1286898416/photo/braille-visually-impaired-writing-system-symbol-formed-out-of-white-spheres.jpg?s=612x612&w=0&k=20&c=c6C9wTwBDPvqYJuiNUJmaqga4cGAY-fy5E6gr24UYv8=",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Text("data"),
                    CupertinoButton(
                      child: const Text("test"),
                      onPressed: () {
                        Navigator.push(context, CupertinoPageRoute(builder: ((context) {
                          return ImageResultPage(image: widget.image);
                        })));
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
