import 'package:flutter/material.dart';
import 'package:delivery_admin/constants.dart';
import '../RecentOrders/recent_order.dart';

class TopButton extends StatelessWidget {
  final String name;
  final String img;
  const TopButton({
    Key? key,
    required this.name,
    required this.img,
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
            if(name =='Recent Orders'){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>const RecentOrders()));
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, bottom: 10, right: 15, left: 10),
                child: Image.asset(
                  img,
                  height: 45,
                ),
              ),
              Text(
                name,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              )
            ],
          )),
    );
  }
}