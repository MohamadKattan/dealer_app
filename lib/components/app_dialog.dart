import 'package:dealer/components/app_btn.dart';
import 'package:dealer/components/app_text.dart';
import 'package:flutter/material.dart';

class AppDialog {
  static Future<void> dialogBuilder(
      {required BuildContext context,
      required String title,
      required String content,
      Function()? onPressedPop,
      required String txtPop,
      bool? secondBtn,
      Function()? onPressedSecond,
      String? txtSecond}) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: 200,
          child: AlertDialog(
            title: AppText.normalText(title),
            content: AppText.normalText(content),
            actions: <Widget>[
              AppBtn.elevBtn(
                  onPressed: onPressedPop, txt: txtPop, bgColor: Colors.white),
              if (secondBtn ?? false)
                AppBtn.elevBtn(
                    onPressed: onPressedSecond,
                    txt: txtSecond ?? '',
                    bgColor: Colors.white)
            ],
          ),
        );
      },
    );
  }
}
