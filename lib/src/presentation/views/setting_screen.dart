import 'package:flutter/material.dart';

import '../widgets/drop_down_button.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              right: 10.0,
              left: 10.0,
            ),
            child: Row(
              children: const [
                Flexible(
                  flex: 1,
                  child: Text(
                    'Database Type:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: DropDownDbMenu(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
