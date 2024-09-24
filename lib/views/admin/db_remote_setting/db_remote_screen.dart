import 'package:auto_route/auto_route.dart';
import 'package:dealer/components/app_btn.dart';
import 'package:dealer/components/app_dialog.dart';
import 'package:dealer/components/app_divider.dart';
import 'package:dealer/components/app_drop_menue.dart';
import 'package:dealer/components/app_indicators.dart';
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
  String? errorColumn;
  List listCreateColumns = [];
  List? listAllTables;

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
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          body: BlocBuilder<DbRemoteBloc, DbRemoteState>(
            builder: (_, state) {
              if (state is Inite) {
                context.read<DbRemoteBloc>().add(GetAllTablesEvent());
              }
              if (state is LoudingState) {
                return _louding();
              }
              if (state is GetAllTablesState) {
                if (state.tables != null) {
                  listAllTables = state.tables;
                }
              }
              if (state is ClickCreateTableState) {
                isCreate = state.isClicked ?? false;
              }
              if (state is CancleCreateTableState) {
                isCreate = state.isClicked ?? true;
                _clear(init: true);
              }
              if (state is SaveTableOnRemoteDbState) {
                if (state.error != null) {
                  _showMsg(context, state.error!);
                  state.error = null;
                }
                if (state.msg != null) {
                  _showMsg(context, state.msg!);
                  state.msg = null;
                  _clear(init: true);
                  context.read<DbRemoteBloc>().add(GetAllTablesEvent());
                }
              }
              if (state is TruncateTableState) {
                if (state.msg != null) {
                  _showMsg(context, state.msg!);
                  state.msg = null;
                }
              }
              if (state is DeleteTableState) {
                if (state.msg != null) {
                  _showMsg(context, state.msg!).whenComplete(() {
                    if (!context.mounted) return;
                    context.read<DbRemoteBloc>().add(GetAllTablesEvent());
                  });
                  state.msg = null;
                }
              }
              if (state is ShowTableInfoState) {
                if (state.msg != null) {
                  _showMsg(context, state.msg!);
                  state.msg = null;
                }
                if (state.data != null) {
                  _allColumnsInOneTable(
                      state.data, context, state.tableName ?? '');
                  state.data = null;
                }
              }
              if (state is DeleteOneColumnState) {
                if (state.msg != null) {
                  _showMsg(context, state.msg!);
                  state.msg = null;
                }
              }

              if (state is EditTableState) {
                if (state.msg != null) {
                  _showMsg(context, state.msg!);
                  state.msg = null;
                  _clear(init: true);
                }
              }
              return _body();
            },
          ),
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
          const SizedBox(height: 20),
          _getAllTables(),
          _startCreateNewTable(),
          _listOfColumnBeforSave(),
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
                if (isCreate) return;
                context.read<DbRemoteBloc>().add(ClickCreateTableEvent());
              },
              txt: 'Create'),
          AppBtn.cardBtn(
              function: () {
                if (!isCreate) return;
                context.read<DbRemoteBloc>().add(CancleCreateTableEvent());
              },
              txt: 'Cancle',
              color: Colors.redAccent),
          AppBtn.cardBtn(txt: 'Refresh', color: Colors.amber),
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

// get all table from remote db that exist
  Widget _getAllTables() {
    return listAllTables != null
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: AppText.normalText(
                      'Number of tables\nThat exist in your db is ${listAllTables?.length ?? 0}',
                    ),
                  ),
                ),
                _headerGetAllTable(),
                _bodyListOfGetTable(),
              ],
            ),
          )
        : const SizedBox();
  }

  Widget _headerGetAllTable() {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Table(
        border: TableBorder.all(borderRadius: BorderRadius.circular(8.0)),
        children: [
          TableRow(
            decoration: const BoxDecoration(color: Colors.white),
            children: [
              TableCell(child: Center(child: AppText.normalText('Table Name'))),
              TableCell(child: Center(child: AppText.normalText('Table Info'))),
              TableCell(child: Center(child: AppText.normalText('Edite'))),
              TableCell(
                  child: Center(child: AppText.normalText('Truncet Table'))),
              TableCell(
                  child: Center(child: AppText.normalText('Delete Table'))),
            ],
          )
        ],
      ),
    );
  }

  Widget _bodyListOfGetTable() {
    return SizedBox(
      height: listAllTables!.length * 50.0,
      child: ListView.builder(
        itemCount: listAllTables!.length,
        itemBuilder: (_, i) {
          Color rowColor = i % 2 == 0 ? Colors.grey[300]! : Colors.white;
          return Padding(
            padding: const EdgeInsets.only(right: 12.0, left: 12.0),
            child: Table(
              border: TableBorder.all(borderRadius: BorderRadius.circular(8.0)),
              children: [
                TableRow(
                  decoration: BoxDecoration(color: rowColor),
                  children: [
                    TableCell(
                        child: Center(
                            child: AppText.normalText(
                                listAllTables?[i] ?? 'null'))),
                    TableCell(
                        child: AppBtn.iconBtn(
                            onPressed: () => _showTableInfo(listAllTables?[i]),
                            icon: Icons.remove_red_eye_outlined)),
                    TableCell(
                        child: AppBtn.iconBtn(
                            onPressed: () {
                              _editTable(listAllTables?[i], context);
                            },
                            icon: Icons.edit)),
                    TableCell(
                        child: AppBtn.iconBtn(
                            onPressed: () {
                              _beforTranctTable(i);
                            },
                            icon: Icons.cleaning_services_rounded)),
                    TableCell(
                        child: AppBtn.iconBtn(
                            onPressed: () => _beforDeleteTable(i),
                            icon: Icons.delete_forever,
                            color: Colors.red)),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future _allColumnsInOneTable(
      List? data, BuildContext context, String tableName) async {
    Future.delayed(const Duration(seconds: 1)).whenComplete(
      () {
        if (!context.mounted) return;
        AppDialog.dialogBuilder(
          context: context,
          title: 'Columns In \n Table $tableName',
          content: '------------',
          widget: data != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: UiResponsive.globalMedia(context: context) / 2,
                        child: Table(
                          border: TableBorder.all(
                              borderRadius: BorderRadius.circular(8.0)),
                          children: [
                            TableRow(
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              children: [
                                TableCell(
                                    child: Center(
                                        child:
                                            AppText.normalText('Name & No'))),
                                TableCell(
                                    child: Center(
                                        child: AppText.normalText('Type'))),
                                TableCell(
                                    child: Center(
                                        child: AppText.normalText('Null'))),
                                TableCell(
                                    child: Center(
                                        child: AppText.normalText(
                                            'Delete Column'))),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: data.length * 50.0,
                        width: UiResponsive.globalMedia(context: context) / 2,
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: data.length,
                          itemBuilder: (_, i) {
                            Color rowColor =
                                i % 2 == 0 ? Colors.grey[300]! : Colors.white;
                            return Table(
                              border: TableBorder.all(
                                  borderRadius: BorderRadius.circular(8.0)),
                              children: [
                                TableRow(
                                  decoration: BoxDecoration(color: rowColor),
                                  children: [
                                    TableCell(
                                        child: Center(
                                            child: AppText.normalText(
                                                'No:${i + 1} - ${data[i]['name']}'))),
                                    TableCell(
                                        child: Center(
                                            child: AppText.normalText(
                                                '${data[i]['type']}'))),
                                    TableCell(
                                        child: Center(
                                            child: AppText.normalText(
                                                '${data[i]['null']}'))),
                                    TableCell(
                                      child: AppBtn.iconBtn(
                                          icon: Icons.delete_forever,
                                          onPressed: () {
                                            _beforDelOneColumn(tableName,
                                                data[i]['name'], context);
                                          }),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : AppIndicators.loadingCircularIndicator,
          txtPop: 'okay',
          onPressedPop: () {
            HelperMethods.popMethod(context);
          },
        );
      },
    );
  }

// to create new table
  Widget _startCreateNewTable() {
    double width = UiResponsive.globalMedia(context: context);
    return isCreate
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
                  ],
                ),
              ),
            ),
          )
        : const SizedBox();
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
              Row(
                children: [
                  listCreateColumns.isNotEmpty
                      ? AppBtn.iconBtn(
                          onPressed: () {
                            AppDialog.dialogBuilder(
                                context: context,
                                title: 'SAVE New TABLE',
                                content:
                                    'BY CLICK ON Greate BTN YOUR ARE GOING TO GREATE NEW TABLE ON YOUR REMOTE DATABASE',
                                txtPop: 'Cancel',
                                onPressedPop: () =>
                                    HelperMethods.popMethod(context),
                                secondBtn: true,
                                onPressedSecond: () => _saveToRemoteDb(context),
                                txtSecond: 'Create');
                          },
                          icon: Icons.save,
                          size: 30)
                      : const SizedBox(),
                  AppBtn.iconBtn(
                      onPressed: () {
                        _addAndclear();
                        context.read<DbRemoteBloc>().add(AddNewColumnEvent());
                      },
                      icon: Icons.add,
                      size: 30),
                ],
              )
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
    return Builder(builder: (context) {
      double width = UiResponsive.globalMedia(context: context);
      return Center(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: AppTextField.customField(
                      controller: columnName,
                      labelText: 'Column Name',
                      errorText: errorColumn,
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
            if (width > ScreenSize.isMobile.width)
              Row(
                children: [
                  AppDropMenue.menueDataType(controller: dataType),
                  AppDropMenue.dropDownBool(
                      controller: notNull, label: DropLable.notNull.label),
                  AppDropMenue.dropDownBool(
                      controller: autoIncrement,
                      label: DropLable.autoIncrement.label),
                  AppDropMenue.dropDownBool(
                      controller: primaryKey,
                      label: DropLable.primaryKey.label),
                  AppDropMenue.dropDownBool(
                      controller: forginKey, label: DropLable.forginKey.label),
                ],
              ),
            if (width <= ScreenSize.isMobile.width)
              Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    AppDropMenue.menueDataType(controller: dataType),
                    AppDropMenue.dropDownBool(
                        controller: notNull, label: DropLable.notNull.label),
                  ]),
                  Row(children: [
                    AppDropMenue.dropDownBool(
                        controller: autoIncrement,
                        label: DropLable.autoIncrement.label),
                    AppDropMenue.dropDownBool(
                        controller: primaryKey,
                        label: DropLable.primaryKey.label),
                    AppDropMenue.dropDownBool(
                        controller: forginKey,
                        label: DropLable.forginKey.label),
                  ])
                ],
              )
          ],
        ),
      );
    });
  }

// list of columns befor save in remote database
  Widget _listOfColumnBeforSave() {
    return Column(
      children: [
        listCreateColumns.isNotEmpty
            ? _headerListOfColumnBeforSave()
            : const SizedBox(),
        _bodyListofColumnsBeforSave()
      ],
    );
  }

  Widget _headerListOfColumnBeforSave() {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Table(
        border: TableBorder.all(borderRadius: BorderRadius.circular(8.0)),
        children: [
          TableRow(
            decoration: const BoxDecoration(color: Colors.white),
            children: [
              TableCell(child: Center(child: AppText.normalText('Colum Name'))),
              TableCell(child: Center(child: AppText.normalText('Data Type'))),
              TableCell(child: Center(child: AppText.normalText('Null'))),
              TableCell(child: Center(child: AppText.normalText('Default'))),
              TableCell(child: Center(child: AppText.normalText('Auto ++'))),
              TableCell(
                  child: Center(child: AppText.normalText('Primary Key'))),
              TableCell(child: Center(child: AppText.normalText('Forgin Key'))),
            ],
          )
        ],
      ),
    );
  }

  Widget _bodyListofColumnsBeforSave() {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        itemCount: listCreateColumns.length,
        itemBuilder: (_, i) {
          Color rowColor = i % 2 == 0 ? Colors.grey[300]! : Colors.white;
          return Padding(
            padding: const EdgeInsets.only(right: 12.0, left: 12.0),
            child: Table(
              border: TableBorder.all(borderRadius: BorderRadius.circular(8.0)),
              children: [
                TableRow(
                  decoration: BoxDecoration(color: rowColor),
                  children: [
                    TableCell(
                        child: Center(
                            child: AppText.normalText(
                                listCreateColumns[i]['name'] ?? 'null'))),
                    TableCell(
                        child: Center(
                            child: AppText.normalText(
                                '${listCreateColumns[i]['type']}'))),
                    TableCell(
                        child: Center(
                            child: AppText.normalText(
                                '${listCreateColumns[i]['notNull']}'))),
                    TableCell(
                        child: Center(
                            child: AppText.normalText(
                                '${listCreateColumns[i]['defualt']}'))),
                    TableCell(
                        child: Center(
                            child: AppText.normalText(
                                '${listCreateColumns[i]['autoIncrement']}'))),
                    TableCell(
                        child: Center(
                            child: AppText.normalText(
                                '${listCreateColumns[i]['primaryKey']}'))),
                    TableCell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: AppText.normalText(
                                '${listCreateColumns[i]['foreignKey']}'),
                          ),
                          AppBtn.iconBtn(
                              onPressed: () {
                                _removeOneColumn(context, i);
                              },
                              icon: Icons.remove)
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

// louding
  Widget _louding() {
    return Container(
        width: UiResponsive.globalMedia(context: context),
        height: UiResponsive.globalMedia(context: context, isHeight: true),
        color: Colors.black26,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppIndicators.customCircularIndicator(),
            AppText.normalText('Please wait ...')
          ],
        ));
  }

// methods
  Future _addAndclear() async {
    if (columnName.text.isEmpty) {
      errorColumn = 'Column name is empty';
      await Future.delayed(const Duration(seconds: 1));
      errorColumn = null;
      return;
    }
    final newColoumn = {
      "name": columnName.text,
      if (defaultValuse.text.isNotEmpty) "default": defaultValuse.text,
      "type": dataType.text,
      "notNull": notNull.text == 'false' ? false : true,
      "autoIncrement": autoIncrement.text == 'false' ? false : true,
      "primaryKey": primaryKey.text == 'false' ? false : true,
      "foreignKey": forginKey.text == 'false' ? false : true,
    };
    listCreateColumns.add(newColoumn);
    _clear();
  }

  void _removeOneColumn(BuildContext context, int i) {
    listCreateColumns.removeAt(i);
    context.read<DbRemoteBloc>().add(RemoveOneColumnEvent());
  }

  void _saveToRemoteDb(BuildContext context) {
    HelperMethods.popMethod(context);
    context.read<DbRemoteBloc>().add(SaveTableOnRemoteDbEvent(
        tableName: tableName.text, listColumn: listCreateColumns));
  }

  Future _showMsg(BuildContext context, String txt) async {
    Future.delayed(const Duration(milliseconds: 500)).whenComplete(
      () {
        if (!context.mounted) return;
        AppDialog.dialogBuilder(
          context: context,
          title: 'Msg',
          content: txt,
          txtPop: 'okay',
          onPressedPop: () {
            HelperMethods.popMethod(context);
          },
        );
      },
    );
  }

  void _clear({bool? init}) {
    if (init ?? false) {
      isCreate = false;
      tableName.clear();
      listCreateColumns.clear();
    }
    columnName.clear();
    defaultValuse.clear();
    dataType.text = 'CHAR(255)';
    notNull.text = 'false';
    autoIncrement.text = 'false';
    primaryKey.text = 'false';
    forginKey.text = 'false';
  }

  void _beforTranctTable(int i) {
    AppDialog.dialogBuilder(
      context: context,
      title: 'Danger Area',
      bgColor: const Color.fromARGB(255, 215, 161, 157),
      content:
          'By Click on clear btn you are going to delete all data on this table : ${listAllTables?[i] ?? 'null'}',
      txtPop: 'Cancel',
      secondBtn: true,
      txtSecond: 'Clear',
      onPressedPop: () => HelperMethods.popMethod(context),
      onPressedSecond: () {
        HelperMethods.popMethod(context);
        if (listAllTables == null) return;
        context.read<DbRemoteBloc>().add(TruncateTableEvent(listAllTables![i]));
      },
    );
  }

  void _beforDeleteTable(int i) {
    AppDialog.dialogBuilder(
      context: context,
      title: 'Danger Area',
      bgColor: const Color.fromARGB(255, 234, 186, 182),
      content:
          'By Click on Delete btn you are going to delete this table : ${listAllTables?[i] ?? 'null'}',
      txtPop: 'Cancel',
      secondBtn: true,
      txtSecond: 'Delete',
      onPressedPop: () => HelperMethods.popMethod(context),
      onPressedSecond: () {
        HelperMethods.popMethod(context);
        if (listAllTables == null) return;
        context.read<DbRemoteBloc>().add(DeleteTableEvent(listAllTables![i]));
      },
    );
  }

  void _showTableInfo(String tableName) {
    context.read<DbRemoteBloc>().add(ShowTableInfoEvent(tableName));
  }

  void _beforDelOneColumn(
      String tableName, String colName, BuildContext context) {
    AppDialog.dialogBuilder(
      context: context,
      title: 'Danger Area',
      bgColor: const Color.fromARGB(255, 234, 186, 182),
      content:
          'By Click on Delete btn you are going to delete one Column from  the table : $tableName',
      txtPop: 'Cancel',
      secondBtn: true,
      txtSecond: 'Delete',
      onPressedPop: () => HelperMethods.popMethod(context),
      onPressedSecond: () async {
        HelperMethods.popMethod(context);
        await Future.delayed(const Duration(milliseconds: 500));
        if (!context.mounted) return;
        HelperMethods.popMethod(context);

        context
            .read<DbRemoteBloc>()
            .add(DeleteOneColumnEvent(tableName, colName));
      },
    );
  }

  void _editTable(String tableName, BuildContext context) {
    AppDialog.dialogBuilder(
      context: context,
      title: 'Add New Column to \n Table $tableName',
      content: '------------',
      widget: _newColumn(),
      onPressedPop: () => HelperMethods.popMethod(context),
      txtPop: 'Cancel',
      secondBtn: true,
      txtSecond: 'Add',
      onPressedSecond: () async {
        await _addAndclear();

        if (!context.mounted) return;
        HelperMethods.popMethod(context);
        context
            .read<DbRemoteBloc>()
            .add(EditTableEvent(tableName, listCreateColumns[0]));
      },
    );
  }
}
