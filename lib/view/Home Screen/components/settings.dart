import 'package:axolon_inventory_manager/services/Themes/app_theme.dart';
import 'package:axolon_inventory_manager/services/Themes/custom_theme.dart';
import 'package:axolon_inventory_manager/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: Container(
                width: double.infinity,
                
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Select Color'),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            CustomTheme.instanceOf(context)
                                .changeTheme(MyThemes.blueTheme);
                          },
                          child: Card(
                            child: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                color: commonBlueColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            CustomTheme.instanceOf(context)
                                .changeTheme(MyThemes.redTheme);
                          },
                          child: Card(
                            child: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
