import 'package:auto_route/auto_route.dart';
import 'package:dealer/components/app_btn.dart';
import 'package:dealer/components/app_divider.dart';
import 'package:dealer/components/app_drop_menue.dart';
import 'package:dealer/components/app_text.dart';
import 'package:dealer/components/app_text_field.dart';
import 'package:dealer/controller/helper_methods_controller.dart';
import 'package:dealer/router/router_app.gr.dart';
import 'package:dealer/utilities/ui_res_app/ui_responsev_controller.dart';
import 'package:dealer/views/admin/db_remote_setting/bloc/db_remote_bloc.dart';
import 'package:dealer/views/admin/db_remote_setting/bloc/db_remote_event.dart';
import 'package:dealer/views/admin/db_remote_setting/bloc/db_remote_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class DbRemoteScreen extends StatefulWidget {
  const DbRemoteScreen({super.key});

  @override
  State<DbRemoteScreen> createState() => _DbRemoteScreenState();
}

class _DbRemoteScreenState extends State<DbRemoteScreen> {
  bool isCreate = false;
  final tableName = TextEditingController();
  final columnName = TextEditingController();
  final dataType = TextEditingController();
  final notNull = TextEditingController();
  final primaryKey = TextEditingController();
  final forginKey = TextEditingController();
  final autoIncrement = TextEditingController();
  final defaultValuse = TextEditingController();
  final map = <String, dynamic>{};
  String? errorText;
  List newList = [];

  @override
  void dispose() {
    tableName.dispose();
    columnName.dispose();
    dataType.dispose();
    notNull.dispose();
    primaryKey.dispose();
    forginKey.dispose();
    autoIncrement.dispose();
    defaultValuse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<DbRemoteBloc, DbRemoteState>(
          builder: (_, state) {
            if (state is Inite) {}
            if (state is LoudingState) {}
            if (state is ClickCreateTableState) {
              isCreate = state.isClicked ?? false;
            }
            if (state is CancleCreateTableState) {
              isCreate = state.isClicked ?? true;
            }
            if (state is AddNewColumnState) {}
            if (state is RemoveOneColumnState) {}
            if (state is RefreshTableState) {}
            return _body(state);
          },
        ),
      ),
    );
  }

  Widget _body(DbRemoteState state) {
    double width = UiResponsive.globalMedia(context: context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(color: Colors.lightBlue.shade100, height: 8.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppBtn.cardBtn(
                    color: Colors.greenAccent,
                    function: () {
                      if (isCreate) return;
                      context.read<DbRemoteBloc>().add(ClickCreateTableEvent());
                    },
                    txt: 'Create'),
                AppBtn.cardBtn(
                    function: () {
                      if (!isCreate) return;
                      context
                          .read<DbRemoteBloc>()
                          .add(CancleCreateTableEvent());
                    },
                    txt: 'Cancle',
                    color: Colors.redAccent),
                AppBtn.cardBtn(txt: 'Refresh', color: Colors.amber),
                CircleAvatar(
                  radius: 25,
                  child: AppBtn.iconBtn(
                    onPressed: () {
                      HelperMethods.popMethod(context, const ControlRoute());
                    },
                    icon: Icons.exit_to_app_outlined,
                    size: 35,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          isCreate
              ? SizedBox(
                  width: width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Column(
                        children: [
                          _titleAndBtn(),
                          _divider(),
                          _newColumn(),
                          // SizedBox(
                          //   height: hightlistView,
                          //   child: ListView.builder(
                          //     reverse: true,
                          //     itemCount: indexoflistField,
                          //     itemBuilder: (_, i) {
                          //       return Column(
                          //         children: [_divider(i), _newColumn()],
                          //       );
                          //     },
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
          Column(
            children: [
              newList.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: Table(
                        border: TableBorder.all(
                            borderRadius: BorderRadius.circular(8.0)),
                        children: [
                          // header
                          TableRow(
                            decoration:
                                const BoxDecoration(color: Colors.white),
                            children: [
                              TableCell(
                                  child: Center(
                                      child: AppText.normalText('Colum Name'))),
                              TableCell(
                                  child: Center(
                                      child: AppText.normalText('Data Type'))),
                              TableCell(
                                  child: Center(
                                      child: AppText.normalText('Null'))),
                              TableCell(
                                  child: Center(
                                      child: AppText.normalText('Default'))),
                              TableCell(
                                  child: Center(
                                      child: AppText.normalText('Auto ++'))),
                              TableCell(
                                  child: Center(
                                      child:
                                          AppText.normalText('Primary Key'))),
                              TableCell(
                                  child: Center(
                                      child: AppText.normalText('Forgin Key'))),
                            ],
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  itemCount: newList.length,
                  itemBuilder: (_, i) {
                    Color rowColor =
                        i % 2 == 0 ? Colors.grey[300]! : Colors.white;
                    return Padding(
                      padding: const EdgeInsets.only(right: 12.0, left: 12.0),
                      child: Table(
                        border: TableBorder.all(
                            borderRadius: BorderRadius.circular(8.0)),
                        children: [
                          TableRow(
                            decoration: BoxDecoration(color: rowColor),
                            children: [
                              TableCell(
                                  child: Center(
                                      child: AppText.normalText(
                                          newList[i]['ColumnName'] ?? 'null'))),
                              TableCell(
                                  child: Center(
                                      child: AppText.normalText(
                                          newList[i]['DataType'] ?? 'null'))),
                              TableCell(
                                  child: Center(
                                      child: AppText.normalText(
                                          newList[i]['Null'] ?? 'null'))),
                              TableCell(
                                  child: Center(
                                      child: AppText.normalText(
                                          newList[i]['DefualtVal'] ?? 'null'))),
                              TableCell(
                                  child: Center(
                                      child: AppText.normalText(
                                          newList[i]['Auto++'] ?? 'null'))),
                              TableCell(
                                  child: Center(
                                      child: AppText.normalText(
                                          newList[i]['primeryKey'] ?? 'null'))),
                              TableCell(
                                  child: Center(
                                      child: AppText.normalText(
                                          newList[i]['forginKey'] ?? 'null'))),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _titleAndBtn() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.normalText('Create new table',
                  fontSize: 18, fontWeight: FontWeight.bold),
              AppBtn.iconBtn(
                  onPressed: () {
                    _addAndclear();
                    context.read<DbRemoteBloc>().add(AddNewColumnEvent());
                  },
                  icon: Icons.add,
                  size: 30),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: AppTextField.customField(
                  controller: tableName,
                  labelText: 'TableName',
                  hintText: 'Enter Table Name'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _divider() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: DotDivider(
              height: 4,
              dotRadius: 2,
              spacing: 3,
            ),
          ),
          // AppText.normalText('Column No: ${i + 1}',
          //     fontSize: 18, fontWeight: FontWeight.bold),
          // const Expanded(
          //   child: DotDivider(
          //     height: 4,
          //     dotRadius: 2,
          //     spacing: 3,
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _newColumn() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: AppTextField.customField(
                  controller: columnName,
                  labelText: 'Column Name',
                  errorText: errorText,
                  hintText: 'Enter column Name'),
            ),
            Expanded(
              child: AppTextField.customField(
                  controller: defaultValuse,
                  labelText: 'default value',
                  hintText: 'default value if exsist'),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppDropMenue.menueDataType(controller: dataType),
            AppDropMenue.dropDownBool(
                controller: notNull, label: DropLable.notNull.label),
            AppDropMenue.dropDownBool(
                controller: autoIncrement,
                label: DropLable.autoIncrement.label),
            AppDropMenue.dropDownBool(
                controller: primaryKey, label: DropLable.primaryKey.label),
            AppDropMenue.dropDownBool(
                controller: forginKey, label: DropLable.forginKey.label),
          ],
        ),
      ],
    );
  }

  // this method for add one column to list
  void _addAndclear() async {
    if (columnName.text.isEmpty) {
      errorText = 'Column name is empty';
      await Future.delayed(const Duration(seconds: 1));
      errorText = null;
      return;
    }
    if (defaultValuse.text == '') {
      defaultValuse.text = 'false';
    }
    final newColoumn = {
      "ColumnName": columnName.text,
      "DefualtVal": defaultValuse.text,
      "DataType": dataType.text,
      "Null": notNull.text,
      "Auto++": autoIncrement.text,
      "primeryKey": primaryKey.text,
      "forginKey": forginKey.text
    };

    newList.add(newColoumn);
    columnName.clear();
    defaultValuse.clear();
    dataType.text = 'CHAR(255)';
    notNull.text = 'false';
    autoIncrement.text = 'false';
    primaryKey.text = 'false';
    forginKey.text = 'false';
  }
}
