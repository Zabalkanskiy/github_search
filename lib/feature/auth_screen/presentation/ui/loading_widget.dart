import 'package:flutter/material.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Loading extends StatelessWidget {
  final Color? color;
  const Loading({this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color ?? Colors.transparent,
      body: Center(
        child: LoadingAnimationWidget.fourRotatingDots(
          size: 6.h,
          color: Colors.white54,
        ),
      ),
    );
  }
}