import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:delivery_admin/Pages/Home/Pages/Orders/orders_page.dart';
import 'package:flutter/material.dart';
import 'package:delivery_admin/constants.dart';
import 'Pages/CakeShops/CakeShopPage.dart';
import 'Pages/Food/food_page.dart';
import 'Pages/Profile/profile_page.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key? key,}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _botindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(

        color: kRed,
        backgroundColor: kRedDark,
        items: const [
          CustomFaB(
            name: 'Food',
            img:
            'assests/icons/bike.png',
          ),
          CustomFaB(
            name: 'CakeShops',
            img:
            'assests/icons/bike.png',
          ),
          CustomFaB(
            name: 'Orders',
            img: 'assests/icons/van.png',
          ),
          CustomFaB(
            name: 'Manage',
            img:
            'assests/icons/grocery.png',
          ),
        ],
        onTap: (page) {
          setState(() {
            _botindex = page;
          });
        },
      ),
      body: <Widget>[
        const FoodPage(),
        const CakeShopPage(),
        const OrdersPage(),
        const ProfilePage(),
      ][_botindex],
    );
  }
}

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          img,
          height: 25,
        ),
        Text(
          name,
          style: const TextStyle(fontSize: 10,color: Colors.white),
        )
      ],
    );
  }
}