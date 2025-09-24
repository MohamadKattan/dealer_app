import 'package:auto_route/auto_route.dart';
import 'package:dealer/components/app_btn.dart';
import 'package:dealer/components/app_dialog.dart';
import 'package:dealer/components/app_image.dart';
import 'package:dealer/components/app_indicators.dart';
import 'package:dealer/components/app_tables_row.dart';
import 'package:dealer/components/app_text.dart';
import 'package:dealer/components/app_text_field.dart';
import 'package:dealer/controller/helper_methods_controller.dart';
import 'package:dealer/router/router_app.gr.dart';
import 'package:dealer/utilities/style_app/config/style_config.dart';
import 'package:dealer/utilities/ui_res_app/ui_responsev_controller.dart';
import 'package:dealer/views/admin/warehouses/bloc/warehouse_state.dart';
import 'package:dealer/views/admin/warehouses/bloc/warehouses_bloc.dart';
import 'package:dealer/views/admin/warehouses/bloc/warehouses_event.dart';
import 'package:dealer/views/admin/warehouses/model/warehouse_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class WarehousesScreen extends StatefulWidget {
  const WarehousesScreen({super.key});

  @override
  State<WarehousesScreen> createState() => _WarehousesScreenState();
}

class _WarehousesScreenState extends State<WarehousesScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController des = TextEditingController();
  List<WarehouseModel>? warehouses;

  @override
  void dispose() {
    name.dispose();
    des.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<WarehousesBloc, WarehouseState>(
          builder: (context, state) {
            if (state is InitialState) {
              if (state.msg != null) {
                _showMsg(context, state.msg!);
                state.msg = null;
              }
              if (name.text.isNotEmpty) name.clear();
              if (des.text.isNotEmpty) des.clear();
              context.read<WarehousesBloc>().add(InitialEvent());
              return AppIndicators.louding(context);
            }

            if (state is GetWarehousesState) {
              warehouses = state.warehouses;
              return _body(warehouses);
            }

            if (state is ErrorWarehousesState) {
              _showMsg(context, state.msg);
              return _body(warehouses);
            }

            if (state is FormSubmitState) {
              if (state.msg != null) {
                _showMsg(context, state.msg!);
                state.msg = null;
              }
              return submitForm(state);
            }

            return AppIndicators.louding(context, txt: 'Some thing went wrong');
          },
        ),
      ),
    );
  }

  Widget _body(List<WarehouseModel>? warehouses) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(color: Colors.lightBlue.shade100, height: 8.0),
          _header(),
          _label(warehouses?.length ?? 0),
          AppTables.customHeadrTable(HeadRowsTypes.wareHouse.list),
          warehouses != null
              ? AppTables.dynmicTable(
                  warehouses, BodyTableType.warehouses, context)
              : AppIndicators.louding(context,
                  txt: 'No warehouses exist yet ..')
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
                context
                    .read<WarehousesBloc>()
                    .add((ShowFormSubmitEvent(isEdite: false)));
              },
              txt: 'New warehouse'),
          AppBtn.cardBtn(
              color: Colors.orangeAccent, function: () {}, txt: 'New item'),
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

  Widget _label(int? number) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: AppText.normalText(
              'Number of warehouses\n That exist in your db is ${number ?? 0}',
            ),
          ),
        ),
      ],
    );
  }

  Widget submitForm(FormSubmitState state) {
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
                          controller: name,
                          labelText: 'WareHouse name',
                          hintText: 'Type warehouse name',
                          icons: Icons.warehouse),
                      AppTextField.customField(
                          controller: des,
                          labelText: 'des',
                          hintText: 'type des of warehouse',
                          icons: Icons.add_home_work_sharp),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AppBtn.elevBtn(
                              txt: 'Cancel',
                              bgColor: Colors.red,
                              onPressed: () => context
                                  .read<WarehousesBloc>()
                                  .add(InitialEvent())),
                          AppBtn.elevBtn(
                            txt: 'Submit',
                            onPressed: () {
                              _edieteOrCreate(state);
                            },
                          ),
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

  void _showMsg(BuildContext context, String msg) {
    Future.delayed(const Duration(milliseconds: 300)).whenComplete(() {
      if (!context.mounted) return;
      AppDialog.dialogBuilder(
        context: context,
        title: 'Msg',
        content: msg,
        txtPop: 'okay',
        onPressedPop: () {
          HelperMethods.popMethod(context);
        },
      );
    });
  }

  void _edieteOrCreate(FormSubmitState state) {
    bool? isForEidet = state.isForEidet ?? false;
    context.read<WarehousesBloc>().add(isForEidet
        ? EditeWarehouseEvent(
            newName: name.text,
            newDes: des.text,
            id: state.id,
            oldName: state.oldName,
            oldDes: state.oldDes)
        : CreateWarehouseEvent(name: name.text, des: des.text));
  }
}
