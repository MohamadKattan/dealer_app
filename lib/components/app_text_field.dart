import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// thsi class will include forms
class AppTextField {
  static Widget customField(
      {required TextEditingController controller,
      Function(String)? onChanged,
      double? width,
      double? padding,
      String? labelText,
      String? hintText,
      bool? obscureText,
      TextInputType? keyboardType,
      List<TextInputFormatter>? inputFormatters,
      Widget? suffixIcon,
      Widget? suffix,
      String? errorText,
      IconData? icons}) {
    return Padding(
      padding: EdgeInsets.all(padding ?? 8.0),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        keyboardType: keyboardType,
        obscureText: obscureText ?? false,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          labelText: labelText,
          errorText: errorText,
          hintText: hintText,
          suffix: suffix ?? const Icon(Icons.abc),
          prefixIcon: Icon(icons),
          suffixIcon: suffixIcon,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
