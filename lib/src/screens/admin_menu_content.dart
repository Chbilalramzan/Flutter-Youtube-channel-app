import 'package:flutter/material.dart';
import '../constants/dummy_menus.dart';

class AdminMenuContents extends StatelessWidget {
  // final String adminMenuId;
  // final String adminMenuTitle;
  //
  // const AdminMenuContents(this.adminMenuId, this.adminMenuTitle);

  static const String routeName = 'admin_menu_contents';

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings as Map<String, String>;
    final adminMenuTitle = routeArgs['label'];
    final adminMenuId = routeArgs['id'];
    final adminMenuContents = DUMMY_CONTENT.where((menucontents) {
      return menucontents.menus.contains(adminMenuId);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(adminMenuTitle),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Text(adminMenuContents[index].title);
        },
        itemCount: adminMenuContents.length,
      ),
    );
  }
}
