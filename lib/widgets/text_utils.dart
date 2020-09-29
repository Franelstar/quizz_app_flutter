import 'package:flutter/material.dart';

class TextUtils extends Text {
  TextUtils(String text, {color: Colors.white, textScaleFactor: 1.0}):
        super(
        text,
        textScaleFactor: textScaleFactor,
        textAlign: TextAlign.center,
        style: TextStyle(color: color)
      );
}