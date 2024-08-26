import 'package:flutter/material.dart';

class AppText {
  static Widget normalTxet(String txt, {double? fontSize}) {
    return Text(
      txt,
      style: TextStyle(fontSize: fontSize ?? 18),
    );
  }
}
