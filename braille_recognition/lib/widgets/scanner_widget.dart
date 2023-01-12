import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';

class ScannerAnimation extends AnimatedWidget {
  final bool stopped;
  final double height;

  ScannerAnimation(
    this.stopped,
    this.height, {
    Key? key,
    required Animation<double> animation,
  }) : super(
          key: key,
          listenable: animation,
        );

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    final scorePosition = (animation.value * height) - 60;

    Color color1 = Color(0x5526A6D6);
    Color color2 = Color(0x0026A6D6);

    if (animation.status == AnimationStatus.reverse) {
      color1 = Color(0x0026A6D6);
      color2 = Color(0x5526A6D6);
    }

    return Positioned(
      bottom: scorePosition,
      left: 0,
      right: 0,
      child: Opacity(
        opacity: (stopped) ? 0.0 : 1.0,
        child: Container(
          height: 60.0,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.9],
              colors: [color1, color2],
            ),
          ),
        ),
      ),
    );
  }
}
