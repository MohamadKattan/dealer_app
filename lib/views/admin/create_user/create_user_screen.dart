import 'package:auto_route/auto_route.dart';
import 'package:dealer/components/app_btn.dart';
import 'package:dealer/components/app_dialog.dart';
import 'package:dealer/components/app_drop_menue.dart';
import 'package:dealer/components/app_image.dart';
import 'package:dealer/components/app_text_field.dart';
import 'package:dealer/controller/helper_methods_controller.dart';
import 'package:dealer/router/router_app.gr.dart';
import 'package:dealer/utilities/style_app/config/style_config.dart';
import 'package:dealer/utilities/ui_res_app/ui_responsev_controller.dart';
import 'package:dealer/views/admin/create_user/bloc/create_user_bloc.dart';
import 'package:dealer/views/admin/create_user/bloc/create_user_event.dart';
import 'package:dealer/views/admin/create_user/bloc/create_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({super.key});

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final nameController = TextEditingController();
  final passController = TextEditingController();
  final addressController = TextEditingController();
  final perController = TextEditingController();
  bool show = true;
  bool isLoudingBtn = false;
  @override
  void dispose() {
    nameController.dispose();
    passController.dispose();
    addressController.dispose();
    perController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body:
          BlocBuilder<CreateUserBloc, UserSettingsStates>(builder: (_, state) {
        if (state is InitialState) {}
        if (state is ShowHidePassWordState) {
          show = state.isShow;
        }
        if (state is SignUpUserState) {
          isLoudingBtn = state.isLouding ?? false;
          if (state.msg != null) {
            _showMsg(context, state.msg!);
            state.msg = null;
          }
        }
        return _body(state);
      }),
    ));
  }

  // main
  Widget _body(UserSettingsStates state) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(color: Colors.lightBlue.shade100, height: 8.0),
          _header(),
          _signUpForm(state)
        ],
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CircleAvatar(
            radius: 25,
            child: AppBtn.iconBtn(
              onPressed: () {
                HelperMethods.popMethod(context,
                    rePlace: true, route: const ControlRoute());
              },
              icon: Icons.exit_to_app_outlined,
              size: 35,
            ),
          ),
        ],
      ),
    );
  }

  Widget _signUpForm(UserSettingsStates state) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 60),
            AppImage.imageByte(
                height: 120, width: 120, img: DefaultValuse.defaultSplashImg),
            Builder(
              builder: (context) {
                final newWidth = UiResponsive.globalMedia(context: context);
                return SizedBox(
                  width: newWidth >= ScreenSize.isIpad.width ? 400 : null,
                  child: Column(
                    children: [
                      AppTextField.customField(
                          controller: nameController,
                          labelText: AppLocalizations.of(context)!.lableName,
                          hintText: AppLocalizations.of(context)!.hintName,
                          icons: Icons.person),
                      AppTextField.customField(
                          controller: passController,
                          suffix: IconButton(
                              onPressed: () {
                                context
                                    .read<CreateUserBloc>()
                                    .add(ShowHidePassWordEvent(show));
                              },
                              icon: Icon(show
                                  ? Icons.visibility
                                  : Icons.visibility_off)),
                          labelText: AppLocalizations.of(context)!.lablePass,
                          hintText: AppLocalizations.of(context)!.hintName,
                          obscureText: show,
                          icons: Icons.password),
                      AppTextField.customField(
                          controller: addressController,
                          labelText: 'Address',
                          hintText: AppLocalizations.of(context)!.hintName,
                          icons: Icons.add_home_work_sharp),
                      AppDropMenue.customDropMenu(
                          controller: perController,
                          label: 'Permissions',
                          value: CustomDropMenuLevel.firstVal.list),
                      const SizedBox(height: 20),
                      !isLoudingBtn
                          ? AppBtn.elevBtn(
                              txt: AppLocalizations.of(context)!.btnLogin,
                              onPressed: () {
                                _createNewUser();
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
    );
  }

  void _createNewUser() {
    context.read<CreateUserBloc>().add(SginUpUserEvent(
        userName: nameController.text,
        passWord: passController.text.trim(),
        per: perController.text,
        address: addressController.text));
  }

  Future _showMsg(BuildContext context, String txt, {Color? color}) async {
    Future.delayed(const Duration(milliseconds: 300)).whenComplete(
      () {
        if (!context.mounted) return;
        AppDialog.dialogBuilder(
          context: context,
          title: 'Msg',
          content: txt,
          txtPop: 'okay',
          bgColor: color,
          onPressedPop: () {
            HelperMethods.popMethod(context);
          },
        );
      },
    );
  }
}
