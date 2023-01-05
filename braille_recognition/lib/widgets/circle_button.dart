import 'package:braille_recognition/widgets/ontap_scale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CircleButton extends StatelessWidget {
  CircleButton({super.key, required this.size, required this.onTap});
  double size = 10;
  Function onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: OnTapScaleAndFade(
        onTap: () {
          onTap();
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(size / 2)),
            gradient: const LinearGradient(colors: [
              Color(0xFFB3EAFF),
              Color(0xFF4AB7E0),
              Color(0xFF0AB0EF),
            ], tileMode: TileMode.clamp),
          ),
          child: Center(
            child: SvgPicture.asset(
              "images/arrow_right.svg",
              width: 20,
              height: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
