import 'package:flutter/material.dart';
import 'package:delivery_admin/constants.dart';


// ignore: use_key_in_widget_constructors
class CakeAppBar extends StatelessWidget with PreferredSizeWidget{
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kRed,
      elevation: 0,
      leading: const Icon(Icons.admin_panel_settings),
      title: Text('Welcome Admin'),
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(65);
}