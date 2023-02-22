import 'package:flutter/material.dart';

class PaddingCustom {
  static const EdgeInsets paddingHorizontal =
      EdgeInsets.symmetric(horizontal: 10);
  static const EdgeInsets paddingHorizontalVertival =
      EdgeInsets.symmetric(horizontal: 12, vertical: 8);

  static double mq(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width;
  }

  static EdgeInsets horizontal(double padding) {
    return EdgeInsets.symmetric(horizontal: padding);
  }

  static InputBorder borderRadiusCircular = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: const BorderSide(color: Colors.black),
  );
}
