import 'package:flutter/material.dart';
import 'package:delivery_admin/constants.dart';

class ProfileAppBar extends StatelessWidget with PreferredSizeWidget{
  const ProfileAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'PROFILE',
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
      backgroundColor: kRed,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
      ],
      elevation: 0,
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(65);
}