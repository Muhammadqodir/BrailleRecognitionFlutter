import 'package:braille_recognition/widgets/ontap_scale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  MyButton({super.key, required this.onTap, required this.child, this.height = 40, this.width = double.infinity});
  double height = 40;
  double width = double.infinity;
  Function onTap;
  Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: OnTapScaleAndFade(
        onTap: () {
          onTap();
        },
        child: child,
      ),
    );
  }
}
