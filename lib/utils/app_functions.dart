import 'package:flutter/material.dart';

class AppFunctions {
  // input border
  static OutlineInputBorder inputBorder({
    required Color borderColor,
    required double radius,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: borderColor, width: 2),
    );
  }
}
