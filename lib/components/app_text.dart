import 'package:flutter/material.dart';

class AppText {
  static Widget normalText(String txt,
      {double? fontSize,
      double? padding,
      TextAlign? textAlign,
      FontWeight? fontWeight}) {
    return Padding(
      padding: EdgeInsets.all(padding ?? 6.0),
      child: Text(
        textAlign: textAlign ?? TextAlign.center,
        txt,
        style: TextStyle(fontSize: fontSize ?? 16, fontWeight: fontWeight),
      ),
    );
  }
}
