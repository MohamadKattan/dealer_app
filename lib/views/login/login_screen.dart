import 'package:auto_route/auto_route.dart';
import 'package:dealer/components/app_btn.dart';
import 'package:dealer/components/app_dialog.dart';
import 'package:dealer/components/app_image.dart';
import 'package:dealer/components/app_text_field.dart';
import 'package:dealer/router/router_app.gr.dart';
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
  bool show = true;
  String? errorName;
  String? errorPassword;

  @override
  void dispose() {
    userName.dispose();
    passWord.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _body(context);
  }

  Widget _body(BuildContext context) {
    StackRouter router = context.router;
    return BlocBuilder<LoginBloc, int>(
      builder: (_, state) {
        if (state == LoginStateLavel.initLogin.state) {
          errorName = null;
          errorPassword = null;
        }
        if (state == LoginStateLavel.errorName.state) {
          errorName = AppLocalizations.of(context)!.userNameIsRequired;
        }
        if (state == LoginStateLavel.errorPassword.state) {
          errorPassword = AppLocalizations.of(context)!.passWordIsRequired;
        }
        if (state == LoginStateLavel.weakPassword.state) {
          errorPassword = AppLocalizations.of(context)!.weakPassword;
        }
        if (state == LoginStateLavel.successLogin.state) {
          router.replace(const HomeRoute());
        }
        if (state == LoginStateLavel.failLogin.state) {
          Future.delayed(const Duration(milliseconds: 500)).whenComplete(
            () {
              if (!context.mounted) return;
              AppDialog.dialogBuilder(
                  context: context,
                  title: AppLocalizations.of(context)!.titleErrorLogin,
                  content: AppLocalizations.of(context)!.contentErrorLogin,
                  txtPop: AppLocalizations.of(context)!.okBtn,
                  onPressedPop: () => router.popUntilRoot());
            },
          );
        }
        return PopScope(
          canPop: false,
          child: SafeArea(
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
                            width: newWidth >= ScreenSize.isIpad.width
                                ? 400
                                : null,
                            child: Column(
                              children: [
                                AppTextField.customField(
                                    controller: userName,
                                    errorText: errorName,
                                    labelText:
                                        AppLocalizations.of(context)!.lableName,
                                    hintText:
                                        AppLocalizations.of(context)!.hintName,
                                    icons: Icons.person),
                                AppTextField.customField(
                                    controller: passWord,
                                    errorText: errorPassword,
                                    suffix: IconButton(
                                        onPressed: () {
                                          show = !show;
                                          context
                                              .read<LoginBloc>()
                                              .isShowPassword(show);
                                        },
                                        icon: Icon(show
                                            ? Icons.visibility
                                            : Icons.visibility_off)),
                                    labelText:
                                        AppLocalizations.of(context)!.lablePass,
                                    hintText:
                                        AppLocalizations.of(context)!.hintName,
                                    obscureText: show,
                                    icons: Icons.password),
                                const SizedBox(height: 20),
                                state != LoginStateLavel.startLogin.state
                                    ? AppBtn.elevBtn(
                                        txt: AppLocalizations.of(context)!
                                            .btnLogin,
                                        onPressed: () {
                                          context
                                              .read<LoginBloc>()
                                              .newLogin(userName, passWord);
                                        },
                                      )
                                    : AppBtn.loudingBtn()
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
