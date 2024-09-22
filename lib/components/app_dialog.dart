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
      Color? bgColor,
      Widget? widget,
      Function()? onPressedSecond,
      String? txtSecond}) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: 200,
          child: AlertDialog(
            backgroundColor: bgColor,
            title: AppText.normalText(title,
                fontSize: 18, fontWeight: FontWeight.bold),
            content: AppText.normalText(content),
            actions: <Widget>[
              if (widget != null) widget,
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppBtn.elevBtn(
                      onPressed: onPressedPop,
                      txt: txtPop,
                      bgColor: Colors.white),
                ),
                if (secondBtn ?? false)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppBtn.elevBtn(
                        onPressed: onPressedSecond,
                        txt: txtSecond ?? '',
                        bgColor: Colors.white),
                  )
              ])
            ],
          ),
        );
      },
    );
  }
}
