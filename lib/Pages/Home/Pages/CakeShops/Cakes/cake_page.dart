import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:delivery_admin/constants.dart';
import 'Components/add_cake.dart';
import 'Components/dish_button.dart';

class CakesPage extends StatelessWidget {
  final String resturantsName;
  const CakesPage({Key? key, required this.resturantsName})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(resturantsName),
        backgroundColor: kRed,
        leading: const Icon(Icons.fastfood),
      ),
      backgroundColor: kYellow,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('cake')
            .where('resturants', isEqualTo: resturantsName).snapshots(),
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
              child: GridView.builder(
                itemCount: snapshot.data!.docs.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 22,
                  mainAxisSpacing: 22,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (
                    context,
                    index,
                    ) {
                  return DishButton(
                      dishName: snapshot.data!.docs[index].get('name'),
                      price: snapshot.data!.docs[index].get('price'),
                      resturants: resturantsName,
                      des: snapshot.data!.docs[index].get('des'),
                      imgUrl: snapshot.data!.docs[index].get('imgUrl'),
                      id: snapshot.data!.docs[index].id
                  );
                },
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        showDialog(context: context, builder: (BuildContext context)=>AddCake(resturants: resturantsName,));
      },child: const Icon(Icons.add),backgroundColor: kRed,),
    );
  }
}
