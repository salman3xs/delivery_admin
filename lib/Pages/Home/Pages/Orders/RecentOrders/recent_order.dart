import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:delivery_admin/constants.dart';
import 'Components/button.dart';

class RecentOrders extends StatelessWidget {
  const RecentOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recent Orders'),
        backgroundColor: kRed,
      ),
      backgroundColor: kYellow,
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('order')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: kRed,
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    shrinkWrap: true,
                    itemBuilder: (context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Slidable(
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              IconButton(
                                  onPressed: () async{
                                    await FirebaseFirestore.instance.collection('order').doc(snapshot.data!.docs[index].id).delete();
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: kRed,
                                  ))
                            ],
                          ),
                          child: OrderButton(
                            id: snapshot.data!.docs[index].id,
                            resturantName: snapshot.data!.docs[index].get('resturant_name').toString(),
                            phone: snapshot.data!.docs[index].get('phone'),
                            type: snapshot.data!.docs[index].get('type'),
                            customer: snapshot.data!.docs[index].get('customer'),
                            address: snapshot.data!.docs[index].get('address'),
                          ),
                        ),
                      );
                    }),
              );
            }
          },
        ),
      ),
    );
  }
}
