import 'package:dealer/components/app_text.dart';
import 'package:dealer/utilities/ui_res_app/ui_responsev_controller.dart';
import 'package:flutter/material.dart';

// enum DropVALDataType {
//   char('CHAR(255)'),
//   varChar('VARCHAR(65535)'),
//   text('TEXT'),
//   smallInt('SMALLINT'),
//   mediumInt('MEDIUMINT'),
//   normalInt('INT'),
//   flout('DOUBLE'),
//   data('DATE'),
//   ttrue('BOOL'),
//   eenum("ENUM('main', 'retail', 'car_sales')");

//   const DropVALDataType(this.val);
//   final String val;
// }

// enum BoolDropvAL {
//   isTrue(true),
//   isFalse(false);

//   const BoolDropvAL(this.val);
//   final bool val;
// }

enum DropdownMenuLable {
  dataType('Data Type'),
  notNull('Not Null'),
  autoIncrement('Auto++'),
  primaryKey('Primary Key'),
  forginKey('Forgin Key'),
  uniQei('Unique'),
  defult('default');

  const DropdownMenuLable(this.label);
  final String label;
}

enum CustomDropMenuLevel {
  boolType(['false', 'true']),
  dataType([
    'CHAR(255)',
    'VARCHAR(65535)',
    'TEXT',
    'SMALLINT',
    'MEDIUMINT',
    'INT',
    'DOUBLE',
    'DATE',
    'BOOL',
    "ENUM('main', 'retail', 'car_sales')"
  ]),
  per(
    ['admin', 'manager', 'acountan', 'retailSales', 'carSales', 'worker'],
  );

  final List list;
  const CustomDropMenuLevel(this.list);
}

class AppDropMenue {
  // static Widget menueDataType({required TextEditingController controller}) {
  //   return Expanded(
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Center(
  //         child: DropdownMenu<DropVALDataType>(
  //           initialSelection: DropVALDataType.char,
  //           controller: controller,
  //           requestFocusOnTap: true,
  //           label: Text(DropdownMenuLable.dataType.label),
  //           onSelected: (DropVALDataType? val) {},
  //           dropdownMenuEntries: DropVALDataType.values
  //               .map<DropdownMenuEntry<DropVALDataType>>((DropVALDataType val) {
  //             return DropdownMenuEntry<DropVALDataType>(
  //               value: val,
  //               label: val.val,
  //               enabled: true,
  //             );
  //           }).toList(),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // static Widget dropDownBool(
  //     {required TextEditingController controller, required String label}) {
  //   return Expanded(
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Center(
  //         child: DropdownMenu<BoolDropvAL>(
  //           initialSelection: BoolDropvAL.isFalse,
  //           controller: controller,
  //           requestFocusOnTap: true,
  //           label: AppText.normalText(label),
  //           onSelected: (BoolDropvAL? val) {},
  //           dropdownMenuEntries: BoolDropvAL.values
  //               .map<DropdownMenuEntry<BoolDropvAL>>((BoolDropvAL val) {
  //             return DropdownMenuEntry<BoolDropvAL>(
  //               value: val,
  //               label: val.val.toString(),
  //               enabled: true,
  //             );
  //           }).toList(),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  static Widget customDropMenu({
    required TextEditingController controller,
    required String label,
    required List value,
  }) {
    return Builder(builder: (context) {
      final newWidth = UiResponsive.globalMedia(context: context);
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownMenu<String>(
          initialSelection: value.first,
          controller: controller,
          requestFocusOnTap: true,
          width: newWidth >= ScreenSize.isIpad.width ? 400 : null,
          label: AppText.normalText(label),
          dropdownMenuEntries: value.map<DropdownMenuEntry<String>>((val) {
            return DropdownMenuEntry<String>(
              value: val.toString(),
              label: val.toString(),
              enabled: true,
            );
          }).toList(),
        ),
      );
    });
  }
}
