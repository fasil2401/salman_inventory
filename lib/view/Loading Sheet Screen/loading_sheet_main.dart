import 'package:axolon_inventory_manager/utils/constants/colors.dart';
import 'package:axolon_inventory_manager/view/Loading%20Sheet%20Screen/loading_sheet_screen.dart';
import 'package:flutter/material.dart';

class LoadingSheetMainScreen extends StatelessWidget {
  const LoadingSheetMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Loading Sheet List',
          ),
          bottom: const TabBar(
            labelStyle:
                TextStyle(color: AppColors.white, fontWeight: FontWeight.w500),
            tabs: <Widget>[
              Tab(
                text: "In Progress",
              ),
              Tab(
                text: "Completed",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            LoadingSheetScreen(
              isInProgress: true,
            ),
            LoadingSheetScreen()
          ],
        ),
      ),
    );
  }
}
