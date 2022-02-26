import 'package:flutter/material.dart';
import 'package:delivery_admin/constants.dart';
import 'Components/app_bar.dart';
import 'Components/middle_button.dart';
import 'Components/options.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ProfileAppBar(),
      backgroundColor: kYellow,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15),
              width: MediaQuery.of(context).size.width,
              color: kBlue,
              child: Column(
                children: const [
                  MiddleButtonList(),
                  OptionList()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


