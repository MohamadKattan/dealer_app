import 'package:auto_route/auto_route.dart';
import 'package:dealer/components/app_btn.dart';
import 'package:dealer/components/app_dialog.dart';
import 'package:dealer/components/app_drop_menue.dart';
import 'package:dealer/components/app_image.dart';
import 'package:dealer/components/app_indicators.dart';
import 'package:dealer/components/app_text.dart';
import 'package:dealer/components/app_text_field.dart';
import 'package:dealer/controller/helper_methods_controller.dart';
import 'package:dealer/router/router_app.gr.dart';
import 'package:dealer/utilities/style_app/config/style_config.dart';
import 'package:dealer/utilities/ui_res_app/ui_responsev_controller.dart';
import 'package:dealer/views/admin/create_user/bloc/user_settings_bloc.dart';
import 'package:dealer/views/admin/create_user/bloc/user_settings_event.dart';
import 'package:dealer/views/admin/create_user/bloc/user_settings_state.dart';
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
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<UserSettingsBloc, UserSettingsStates>(
          builder: (_, state) {
            if (state is InitialState) {
              _clear();
              context.read<UserSettingsBloc>().add(GetAllUsersEvent());
            }

            if (state is LoudingState) {
              return _louding();
            }

            if (state is ShowFormSginUpState) {
              show = state.showPass ?? true;
              if (state.msg != null) {
                _showMsg(context, state.titleMsg ?? 'msg', state.msg!);
                state.msg = null;
                state.titleMsg = null;
              }
              return _signUpForm();
            }

            if (state is SignUpUserState) {
              if (state.msg != null) {
                _showMsg(context, 'Msg', state.msg!);
                state.msg = null;
                context.read<UserSettingsBloc>().add(InitialEvent());
              }
            }

            if (state is GetAllUsersState) {
              return Text(state.data![0].userName.toString());
            }

            return _body();
          },
        ),
      ),
    );
  }

  // main
  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(color: Colors.lightBlue.shade100, height: 8.0),
          _header(),
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
          AppBtn.cardBtn(
              color: Colors.greenAccent,
              function: () {
                context.read<UserSettingsBloc>().add(ShowFormSignUpEvent());
              },
              txt: 'New User'),
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

  Widget _signUpForm() {
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
                                    .read<UserSettingsBloc>()
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
                          value: CustomDropMenuLevel.per.list),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AppBtn.elevBtn(
                            txt: 'Cancel',
                            bgColor: Colors.red,
                            onPressed: () {
                              _initialSettings();
                            },
                          ),
                          AppBtn.elevBtn(
                            txt: 'SginUp',
                            onPressed: () {
                              _createNewUser();
                            },
                          )
                        ],
                      ),
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

  Widget _louding() {
    return Container(
      height: UiResponsive.globalMedia(context: context, isHeight: true),
      width: UiResponsive.globalMedia(context: context),
      color: const Color.fromARGB(66, 44, 41, 41),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppIndicators.loadingCircularIndicator,
          AppText.normalText('Please wait...')
        ],
      ),
    );
  }

  Future _showMsg(BuildContext context, String title, String txt) async {
    Future.delayed(const Duration(milliseconds: 300)).whenComplete(
      () {
        if (!context.mounted) return;
        AppDialog.dialogBuilder(
          context: context,
          title: title,
          content: txt,
          txtPop: 'okay',
          onPressedPop: () {
            HelperMethods.popMethod(context);
          },
        );
      },
    );
  }

  void _initialSettings() {
    context.read<UserSettingsBloc>().add(InitialEvent());
  }

  void _createNewUser() {
    context.read<UserSettingsBloc>().add(SginUpUserEvent(
        userName: nameController.text,
        passWord: passController.text.trim(),
        per: perController.text,
        address: addressController.text));
  }

  void _clear() {
    nameController.clear();
    passController.clear();
    perController.clear();
    addressController.clear();
  }
}
