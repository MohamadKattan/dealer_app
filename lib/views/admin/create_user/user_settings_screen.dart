import 'package:auto_route/auto_route.dart';
import 'package:dealer/components/app_btn.dart';
import 'package:dealer/components/app_dialog.dart';
import 'package:dealer/components/app_drop_menue.dart';
import 'package:dealer/components/app_image.dart';
import 'package:dealer/components/app_indicators.dart';
import 'package:dealer/components/app_tables_row.dart';
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
  int? userId;

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
              return AppIndicators.louding(context);
            }

            if (state is MessagesState) {
              if (state.level != null) {
                _showMsg(context, state.title ?? 'Error',
                    state.msgInfo ?? '***', state.level!);
                state.level = null;
                state.msgInfo = null;
              }
            }

            if (state is ShowFormSginUpState) {
              show = state.showPass ?? true;
              if (state.level != null) {
                _showMsg(context, state.title ?? 'Error',
                    state.msgInfo ?? '***', state.level!);
                state.level = null;
                state.msgInfo = null;
              }
              if (state.isForEidet ?? false) {
                nameController.text = state.userName!;
                addressController.text = state.address!;
                perController.text = state.per!;
                userId = state.userId;
                passController.text = state.passWord!;
              }
              return _signUpForm(state);
            }

            if (state is GetAllUsersState) {
              return _body(state);
            }
            return AppIndicators.louding(context);
          },
        ),
      ),
    );
  }

  // main
  Widget _body(GetAllUsersState state) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(color: Colors.lightBlue.shade100, height: 8.0),
          _header(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: AppText.normalText(
                    'Number of Users\n That exist in your db is ${state.data?.length ?? 0}',
                  ),
                ),
              ),
            ],
          ),
          AppTables.customHeadrTable(HeadRowsTypes.users.list),
          AppTables.dynmicTable(
              state.data ?? [], BodyTableType.userModel, context)
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

  Widget _signUpForm(ShowFormSginUpState state) {
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
                          suffix: state.isForEidet == false
                              ? IconButton(
                                  onPressed: () {
                                    context
                                        .read<UserSettingsBloc>()
                                        .add(ShowHidePassWordEvent(show));
                                  },
                                  icon: Icon(show
                                      ? Icons.visibility
                                      : Icons.visibility_off))
                              : null,
                          labelText: AppLocalizations.of(context)!.lablePass,
                          hintText: AppLocalizations.of(context)!.hintName,
                          obscureText: state.isForEidet == true ? false : show,
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
                            txt: state.isForEidet == true ? 'Edite' : 'SginUp',
                            onPressed: () {
                              _createNewUser(state.isForEidet ?? false);
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

  Future _showMsg(BuildContext context, String title, String moreInfo,
      LevelUserSettingsMsg level) async {
    String? newMsg;
    switch (level) {
      case LevelUserSettingsMsg.errorcreateNewUser:
        newMsg = 'Error while Create New user';
        context.read<UserSettingsBloc>().add(InitialEvent());
        break;
      case LevelUserSettingsMsg.createdNewUser:
        newMsg = 'New User has been created';
        context.read<UserSettingsBloc>().add(InitialEvent());
        break;
      case LevelUserSettingsMsg.getAllUsers:
        newMsg = 'Error while get All Users';
        break;
      case LevelUserSettingsMsg.nameRequired:
        newMsg = 'Username is required';
        break;
      case LevelUserSettingsMsg.passWordRequired:
        newMsg = 'PassWord is required';
        break;
      case LevelUserSettingsMsg.weakPassWord:
        newMsg = 'PassWord is weak\n Example for right format : Password99';
        break;
      case LevelUserSettingsMsg.permissionsRequired:
        newMsg = 'permissions is Required';
        break;
      case LevelUserSettingsMsg.errorDeleteUser:
        newMsg = 'Error while delete user';
        break;
      case LevelUserSettingsMsg.deletedUser:
        newMsg = 'User has been deleted';
        context.read<UserSettingsBloc>().add(InitialEvent());
        break;
      case LevelUserSettingsMsg.errorEditeUser:
        newMsg = 'Error edite user';
        context.read<UserSettingsBloc>().add(InitialEvent());
        break;
      case LevelUserSettingsMsg.editedUser:
        newMsg = 'User info  has been update';
        context.read<UserSettingsBloc>().add(InitialEvent());
        break;
      case LevelUserSettingsMsg.catchError:
        newMsg = 'Un handel errro';
        break;
      default:
        newMsg = 'UnKnown Error';
    }
    Future.delayed(const Duration(milliseconds: 300)).whenComplete(
      () {
        if (!context.mounted) return;
        AppDialog.dialogBuilder(
          context: context,
          title: title,
          content: '$newMsg\n $moreInfo',
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

  void _createNewUser(bool isForEidet) {
    if (isForEidet) {
      context.read<UserSettingsBloc>().add(EditeUserEvents(
          name: nameController.text,
          pass: passController.text.trim(),
          address: addressController.text,
          per: perController.text,
          id: userId));
    } else {
      context.read<UserSettingsBloc>().add(SginUpUserEvent(
          userName: nameController.text,
          passWord: passController.text.trim(),
          per: perController.text,
          address: addressController.text));
    }
  }

  void _clear() {
    nameController.clear();
    passController.clear();
    perController.clear();
    addressController.clear();
  }
}
