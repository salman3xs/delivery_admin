import 'package:flutter/material.dart';
import 'package:delivery_admin/constants.dart';

class OptionList extends StatelessWidget {
  const OptionList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30, left: 15, right: 15, bottom: 15),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: kYellow, borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: const [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                top: 15.0,
                left: 30,
              ),
              child: Text(
                'Manage',
                style: TextStyle(color: kRed, fontSize: 25),
              ),
            ),
          ),
          OptionButton(name: 'Manage Users', icon: Icons.person),
          Divider(
            color: kRed,
            thickness: 2,
          ),
          OptionButton(
            name: 'Payment',
            icon: Icons.account_balance_wallet,
          ),
        ],
      ),
    );
  }
}

class OptionButton extends StatelessWidget {
  final String name;
  final IconData icon;

  const OptionButton({
    Key? key,
    required this.name,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(kYellow),
            elevation: MaterialStateProperty.all(0)),
        onPressed: () async{},
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: kRed,
                child: Icon(
                  icon,
                  size: 35,
                ),
              ),
            ),
            Text(
              name,
              style: const TextStyle(color: kRed, fontSize: 15),
            )
          ],
        ));
  }
}
