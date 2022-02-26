import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:delivery_admin/constants.dart';
import 'Components/bottombutton.dart';
import 'Components/top_buttons.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kRed,
        title: const Text(
          'ORDERS',
          style: TextStyle(color: Colors.white),
        ),
        leading: const Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),
      ),
      backgroundColor: kYellow,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          padding: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          color: kBlue,
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'Available Orders',
                    style: TextStyle(color: Colors.white, fontSize: 28),
                  ),
                ),
              ), // recent deliveries Text
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('order')
                    .where('accepted', isEqualTo: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: kRed,
                      ),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        shrinkWrap: true,
                        itemBuilder: (context, int index) {
                          return BottomButton(
                          id: snapshot.data!.docs[index].id,
                            resturantName: snapshot.data!.docs[index].get('resturant_name').toString(),
                            phone: snapshot.data!.docs[index].get('phone'),
                            type: snapshot.data!.docs[index].get('type'),
                            customer: snapshot.data!.docs[index].get('customer'),
                            address: snapshot.data!.docs[index].get('address'),
                          );
                        },);
                  }
                },
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'Options',
                    style: TextStyle(color: Colors.white, fontSize: 28),
                  ),
                ),
              ), // other options Text
              const TopButton(
                name: 'Recent Orders',
                img: 'assests/icons/truck.png',
              ), // Pickup
              const TopButton(
                name: ' Track Order',
                img: 'assests/icons/location.png',
              ), // TrackOrder
            ],
          ),
        ),
      ),
    );
  }
}
