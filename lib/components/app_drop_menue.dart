import 'package:dealer/components/app_text.dart';
import 'package:flutter/material.dart';

enum DropLable {
  dataType('Data Type'),
  notNull('Null'),
  autoIncrement('Auto++'),
  primaryKey('Primary Key'),
  forginKey('Forgin Key'),
  defult('default');

  const DropLable(this.label);
  final String label;
}

enum DropVALDataType {
  char('CHAR(255)'),
  varChar('VARCHAR(65535)'),
  smallInt('SMALLINT'),
  mediumInt('MEDIUMINT'),
  normalInt('INT'),
  flout('DOUBLE'),
  data('DATE'),
  ttrue('BOOL');

  const DropVALDataType(this.val);
  final String val;
}

enum BoolDropvAL {
  isTrue(true),
  isFalse(false);

  const BoolDropvAL(this.val);
  final bool val;
}

class AppDropMenue {
  static Widget menueDataType({required TextEditingController controller}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: DropdownMenu<DropVALDataType>(
            initialSelection: DropVALDataType.char,
            controller: controller,
            requestFocusOnTap: true,
            label: Text(DropLable.dataType.label),
            onSelected: (DropVALDataType? val) {},
            dropdownMenuEntries: DropVALDataType.values
                .map<DropdownMenuEntry<DropVALDataType>>((DropVALDataType val) {
              return DropdownMenuEntry<DropVALDataType>(
                value: val,
                label: val.val,
                enabled: true,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  static Widget dropDownBool(
      {required TextEditingController controller, required String label}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: DropdownMenu<BoolDropvAL>(
            initialSelection: BoolDropvAL.isFalse,
            controller: controller,
            requestFocusOnTap: true,
            label: AppText.normalText(label),
            onSelected: (BoolDropvAL? val) {},
            dropdownMenuEntries: BoolDropvAL.values
                .map<DropdownMenuEntry<BoolDropvAL>>((BoolDropvAL val) {
              return DropdownMenuEntry<BoolDropvAL>(
                value: val,
                label: val.val.toString(),
                enabled: true,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
