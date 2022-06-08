import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:testproject/src/core/utils/shared_pref_util.dart';

class DropDownDbMenu extends StatefulWidget {
  const DropDownDbMenu({Key? key}) : super(key: key);

  @override
  State<DropDownDbMenu> createState() => _DropDownDbMenuState();
}

class _DropDownDbMenuState extends State<DropDownDbMenu> {
  // Initial Selected Value
  String dropdownvalue = 'Local database';
  final prefUtil = SharedPrefUtil();
  // List of items in our dropdown menu
  final items = [
    'Local database',
    'Hive',
    'Sqflite',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10.0),
      child: FutureBuilder<String>(
        key: Key(
          dropdownvalue,
        ),
        future: prefUtil.getStringValuesSF(),
        builder: ((context, snapshot) {
          return DropdownButton<String>(
            key: UniqueKey(),
            icon: const SizedBox(),
            value: snapshot.data,
            items: items.map((value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) async {
              setState(() {
                if (value != null) {
                  dropdownvalue = value;
                } else {
                  throw Exception('value is null');
                }
              });

              await prefUtil.addString(dropdownvalue);
            },
          );
        }),
      ),
    );
  }
}
