import 'package:delivery_admin/Pages/Home/Pages/Orders/orders_page.dart';
import 'package:flutter/material.dart';
import 'package:delivery_admin/constants.dart';

class MiddleButtonList extends StatelessWidget {
  const MiddleButtonList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        MiddleButton(name: 'ORDERS',img:'assests/icons/van.png'),
        MiddleButton(name: 'OFFERS',img:'assests/icons/gift.png'),
      ],
    );
  }
}

class MiddleButton extends StatelessWidget {
  final String name;
  final String img;
  const MiddleButton({
    Key? key, required this.name, required this.img,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0,left: 5),
      child: ElevatedButton(
          onPressed: () {
            if(name=='ORDERS'){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>const OrdersPage()));
            }
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(kRed),
              shape :MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  )
              ),
              padding: MaterialStateProperty.all(const EdgeInsets.all(20),
              )
          ),
          child: Column(
            children: [
              Image.asset(
                img,
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(name,style: const TextStyle(fontWeight: FontWeight.w400),),
              )
            ],
          )),
    );
  }
}