import 'package:flutter/material.dart';
import '../constants/dummy_menus.dart';
import '../widgets/admin_reusable_card.dart';

class AdminMainScreen extends StatelessWidget {
  static const String routeName = 'admin_main_menu';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Main Menu'),
      ),
      body: GridView(
        padding: const EdgeInsets.all(25.0),
        children: DUMMY_MENUS
            .map((menusData) => ReusableCard(
                  menusData.id,
                  menusData.colour,
                  menusData.label,
                ))
            .toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 20.0,
        ),
      ),
    );
  }
}
