import 'package:dealer/components/app_btn.dart';
import 'package:dealer/components/app_dialog.dart';
import 'package:dealer/components/app_text.dart';
import 'package:dealer/controller/helper_methods_controller.dart';
import 'package:dealer/models/user_model.dart';
import 'package:dealer/views/admin/create_user/bloc/user_settings_bloc.dart';
import 'package:dealer/views/admin/create_user/bloc/user_settings_event.dart';
import 'package:dealer/views/admin/warehouses/bloc/warehouses_bloc.dart';
import 'package:dealer/views/admin/warehouses/bloc/warehouses_event.dart';
import 'package:dealer/views/admin/warehouses/model/warehouse_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum HeadRowsTypes {
  users(["Number", "Name", "Type", "Address", "Delete", "Edite"]),
  wareHouse(["Name", "des", "Delete", "Edite"]);

  final List<String> list;
  const HeadRowsTypes(this.list);
}

enum BodyTableType { userModel, warehouses }

class AppTables {
  static Widget customHeadrTable(List list) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0, left: 12.0),
      child: Table(
        border: TableBorder.all(borderRadius: BorderRadius.circular(8.0)),
        children: [
          TableRow(
            decoration: const BoxDecoration(color: Colors.white),
            children: [
              for (var ele in list) TableCell(child: AppText.normalText(ele))
            ],
          ),
        ],
      ),
    );
  }

  static Widget dynmicTable(
      List list, BodyTableType type, BuildContext context) {
    return SizedBox(
      height: list.length * 50,
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (_, i) {
          return Padding(
            padding: const EdgeInsets.only(right: 12.0, left: 12.0),
            child: Table(
              border: TableBorder.all(borderRadius: BorderRadius.circular(8.0)),
              children: [_dynmicTableCel(list, type, i, context)],
            ),
          );
        },
      ),
    );
  }

  static TableRow _dynmicTableCel(
      List list, BodyTableType type, int i, BuildContext context) {
    switch (type) {
      case BodyTableType.userModel:
        List<UserModel> newUser = List<UserModel>.from(list);
        Color rowColor = i % 2 == 0 ? Colors.grey[300]! : Colors.white;
        return TableRow(
          decoration: BoxDecoration(color: rowColor),
          children: [
            TableCell(child: AppText.normalText('${newUser[i].userId!}')),
            TableCell(child: AppText.normalText(newUser[i].userName!)),
            TableCell(child: AppText.normalText(newUser[i].per!.toUpperCase())),
            TableCell(child: AppText.normalText(newUser[i].address!)),
            AppBtn.iconBtn(
              icon: Icons.delete,
              onPressed: () {
                AppDialog.dialogBuilder(
                  context: context,
                  secondBtn: true,
                  bgColor: const Color.fromARGB(255, 247, 118, 118),
                  title: 'Warning!!',
                  content:
                      'By click on delete btn\nYou are going to delete\nAll data and refrenc for\n The User :***${newUser[i].userName!}***',
                  txtPop: 'Cancel',
                  txtSecond: 'Delete',
                  onPressedSecond: () {
                    HelperMethods.popMethod(context);
                    context
                        .read<UserSettingsBloc>()
                        .add(DeleteOneUserEvent(id: newUser[i].userId!));
                  },
                  onPressedPop: () => HelperMethods.popMethod(context),
                );
              },
            ),
            AppBtn.iconBtn(
              icon: Icons.edit,
              onPressed: () {
                context.read<UserSettingsBloc>().add(ShowFormSignUpEvent(
                    id: newUser[i].userId!,
                    name: newUser[i].userName!,
                    per: newUser[i].per!,
                    address: newUser[i].address!,
                    passWord: newUser[i].passWord!,
                    isForEidet: true));
              },
            ),
          ],
        );
      case BodyTableType.warehouses:
        List<WarehouseModel> warehouse = List<WarehouseModel>.from(list);
        Color rowColor = i % 2 == 0 ? Colors.grey[300]! : Colors.white;
        return TableRow(
          decoration: BoxDecoration(color: rowColor),
          children: [
            // TableCell(child: AppText.normalText('${warehouse[i].id!}')),
            TableCell(child: AppText.normalText(warehouse[i].name!)),
            TableCell(child: AppText.normalText(warehouse[i].des!)),
            AppBtn.iconBtn(
              icon: Icons.delete,
              onPressed: () {
                AppDialog.dialogBuilder(
                  context: context,
                  secondBtn: true,
                  bgColor: const Color.fromARGB(255, 247, 118, 118),
                  title: 'Warning!!',
                  content:
                      'By click on delete btn\nYou are going to delete\nAll data and refrenc for\n The warehouse :***${warehouse[i].name!}***',
                  txtPop: 'Cancel',
                  txtSecond: 'Delete',
                  onPressedSecond: () {
                    context
                        .read<WarehousesBloc>()
                        .add(DeleteWarehousEvent(warehouse[i].id!));
                    HelperMethods.popMethod(context);
                  },
                  onPressedPop: () => HelperMethods.popMethod(context),
                );
              },
            ),
            AppBtn.iconBtn(
              icon: Icons.edit,
              onPressed: () {
                context.read<WarehousesBloc>().add((ShowFormSubmitEvent(
                    isEdite: true,
                    id: warehouse[i].id,
                    oldName: warehouse[i].name,
                    oldDes: warehouse[i].des)));
              },
            ),
          ],
        );

      default:
        return const TableRow();
    }
  }
}
