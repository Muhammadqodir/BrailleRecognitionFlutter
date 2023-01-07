import 'package:braille_recognition/widgets/custom_button.dart';
import 'package:braille_recognition/widgets/ontap_scale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                            color: Color(0xFFA2E7FB),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Cyrilic",
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
                                  "Braille",
                                  textAlign: TextAlign.center,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 12),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(24),
                              bottomRight: Radius.circular(24),
                            ),
                            color: Color(0xFFD5F3FB),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: OnTapScaleAndFade(
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
                                  onTap: () {},
                                ),
                              ),
                              Expanded(
                                child: OnTapScaleAndFade(
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
                                  onTap: () {},
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 4,
                                  blurRadius: 20,
                                  offset: const Offset(0, 10), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 4,
                                  blurRadius: 20,
                                  offset: Offset(
                                      0, 10), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
      ),
    );
  }
}
