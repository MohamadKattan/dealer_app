import 'dart:convert';
import 'package:flutter/material.dart';

class AppImage {
  static Widget imageByte(
      {required String img, double? padding, double? width, double? height}) {
    return Padding(
      padding: EdgeInsets.all(padding ?? 8.0),
      child: Image.memory(
        base64Decode(img),
        width: width,
        height: height,
      ),
    );
  }

  static Widget circleImageByte(
      {required String img,
      double? padding,
      double? radius,
      double? width,
      double? height}) {
    return Padding(
      padding: EdgeInsets.all(padding ?? 8.0),
      child: CircleAvatar(
        radius: radius,
        child: Image.memory(
          base64Decode(img),
          width: width,
          height: height,
        ),
      ),
    );
  }
}
