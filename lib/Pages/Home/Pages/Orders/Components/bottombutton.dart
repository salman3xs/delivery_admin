import 'package:flutter/material.dart';
import 'package:delivery_admin/constants.dart';
import 'order_details.dart';

class BottomButton extends StatelessWidget {
  final String id;
  final String customer;
  final String address;
  final String resturantName;
  final String phone;
  final String type;

  const BottomButton({
    Key? key,
    required this.customer,
    required this.address,
    required this.resturantName,
    required this.phone,
    required this.type, required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(kRed),
            padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
            elevation: MaterialStateProperty.all(0),
          ),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) => OrderDetails(
                  id: id,
                      resturantName: resturantName,
                      phone: phone,
                      type: type,
                      address: address,
                      customer: customer,
                    ),);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                backgroundColor: kYellow,
                radius: 40,
                child: Image.asset(
                  'assests/icons/package.png',
                  height: 50,
                ),
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: customer + '\t\t\t',
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
                const TextSpan(
                  text: '5th Aug' + '\n\n',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w300),
                ),
                TextSpan(
                  text: address + '\n\n',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w300),
                ),
                TextSpan(
                  text: phone,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w300),
                )
              ]))
            ],
          )),
    );
  }
}
