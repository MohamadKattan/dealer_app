import 'package:flutter/material.dart';

class AppText {
  static Widget normalTxet(String txt, {double? fontSize, double? padding}) {
    return Padding(
      padding: EdgeInsets.all(padding ?? 8.0),
      child: Text(
        txt,
        style: TextStyle(fontSize: fontSize ?? 18),
      ),
    );
  }
}
