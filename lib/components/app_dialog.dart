import 'package:dealer/components/app_btn.dart';
import 'package:dealer/components/app_text.dart';
import 'package:dealer/utilities/ui_res_app/ui_responsev_controller.dart';
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
        double width = UiResponsive.globalMedia(context: context);
        return SizedBox(
          width: 200,
          child: AlertDialog(
            backgroundColor: bgColor,
            title: AppText.normalText(title,
                fontSize: 18, fontWeight: FontWeight.bold, padding: 0.0),
            content: AppText.normalText(content, padding: 0.0),
            actions: <Widget>[
              if (widget != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: widget,
                ),
              width <= ScreenSize.isMobile.width
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppBtn.elevBtn(
                              onPressed: onPressedPop,
                              txt: txtPop,
                              bgColor: Colors.white),
                          const SizedBox(height: 10),
                          if (secondBtn ?? false)
                            AppBtn.elevBtn(
                                onPressed: onPressedSecond,
                                txt: txtSecond ?? '',
                                bgColor: Colors.white)
                        ],
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AppBtn.elevBtn(
                                onPressed: onPressedPop,
                                txt: txtPop,
                                bgColor: Colors.white),
                          ),
                        ),
                        if (secondBtn ?? false)
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AppBtn.elevBtn(
                                  onPressed: onPressedSecond,
                                  txt: txtSecond ?? '',
                                  bgColor: Colors.white),
                            ),
                          )
                      ],
                    )
            ],
          ),
        );
      },
    );
  }
}
