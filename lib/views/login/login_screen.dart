import 'package:auto_route/auto_route.dart';
import 'package:dealer/components/app_btn.dart';
import 'package:dealer/components/app_image.dart';
import 'package:dealer/components/app_text_field.dart';
import 'package:dealer/utilities/style_app/config/style_config.dart';
import 'package:dealer/utilities/ui_res_app/ui_responsev_controller.dart';
import 'package:dealer/views/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userName = TextEditingController();
  final passWord = TextEditingController();

  @override
  void dispose() {
    userName.dispose();
    passWord.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UiResponsive.myUiBuilder(context, _body(context));
  }

  Widget _body(BuildContext context) {
    return BlocBuilder<LoginBloc, int>(builder: (_, state) {
      return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 120),
                  AppImage.imageByte(
                      height: 120,
                      width: 120,
                      img: DefaultValuse.defaultSplashImg),
                  Builder(
                    builder: (context) {
                      final newWidth =
                          UiResponsive.globalMedia(context: context);
                      return SizedBox(
                        width: newWidth >= ScreenSize.isIpad.width ? 400 : null,
                        child: Column(
                          children: [
                            AppTextField.customField(
                                controller: userName,
                                labelText:
                                    AppLocalizations.of(context)!.lableName,
                                hintText:
                                    AppLocalizations.of(context)!.hintName,
                                icons: Icons.person),
                            AppTextField.customField(
                                controller: passWord,
                                labelText:
                                    AppLocalizations.of(context)!.lablePass,
                                hintText:
                                    AppLocalizations.of(context)!.hintName,
                                obscureText: true,
                                icons: Icons.password),
                            const SizedBox(height: 20),
                            state == 0
                                ? AppBtn.eleBtn(
                                    txt: AppLocalizations.of(context)!.btnLogin,
                                    onPressed: () {
                                      final name = userName.text;
                                      final pass = passWord.text.trim();
                                      context
                                          .read<LoginBloc>()
                                          .newLogin(name, pass);
                                    })
                                : const SizedBox()
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
