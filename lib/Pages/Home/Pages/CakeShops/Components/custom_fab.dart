import 'package:flutter/material.dart';
import 'package:delivery_admin/constants.dart';

class CustomFaB extends StatelessWidget {
  final String img;
  final String name;

  const CustomFaB({
    Key? key,
    required this.img,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: FloatingActionButton(
        backgroundColor: kRed,
        onPressed: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              img,
              height: 25,
            ),
            Text(
              name,
              style: const TextStyle(fontSize: 10),
            )
          ],
        ),
      ),
    );
  }
}