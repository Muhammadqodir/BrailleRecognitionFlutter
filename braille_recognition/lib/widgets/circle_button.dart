import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  CircleButton({super.key, required this.size});
  double size = 10;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: size,
        width: size,
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
            child: Icon(Icons.forward, color: Colors.white,),
          ),
        ));
  }
}
