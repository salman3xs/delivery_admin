import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:delivery_admin/constants.dart';
import 'Components/app_bar.dart';
import 'Dishes/dishes_page.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({Key? key}) : super(key: key);

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kYellow,
      appBar: FoodAppBar(),
      body: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            width: MediaQuery.of(context).size.width,
            color: kBlue,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'RESTURANTS',
                      style: TextStyle(fontSize: 23, color: Colors.white),
                    ),
                  ),
                ), // Popular Resturants Text
                FutureBuilder<QuerySnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('resturants')
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ResturantsButton(
                                name: snapshot.data!.docs[index].get('name'),
                                address:
                                    snapshot.data!.docs[index].get('address'),
                                allowed: snapshot.data!.docs[index].get('allowed'),
                                id: snapshot.data!.docs[index].id,
                              );
                            });
                      } else {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: kRed,
                        ));
                      }
                    }),
              ],
            )),
      ),
    );
  }
}

class ResturantsButton extends StatefulWidget {
  final String name;
  final String address;
  final String id;
  bool allowed;

  ResturantsButton({
    Key? key,
    required this.name,
    required this.address,
    required this.allowed,
    required this.id,
  }) : super(key: key);

  @override
  State<ResturantsButton> createState() => _ResturantsButtonState();
}

class _ResturantsButtonState extends State<ResturantsButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => DishesPage(
                          resturantsName: widget.name,
                        )));
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  const Color.fromRGBO(20, 72, 102, 1)),
              padding: MaterialStateProperty.all(const EdgeInsets.all(10))),
          child: Row(
            children: [
              Image.asset(
                'assests/icons/001.jpg',
                height: 100,
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: widget.name + '\n',
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                TextSpan(
                    text: widget.address,
                    style: const TextStyle(color: Colors.white, fontSize: 12))
              ])),
              Switch(
                value: widget.allowed,
                onChanged: (value) {
                  setState(() {
                    widget.allowed = value;
                    FirebaseFirestore.instance
                        .collection('resturants')
                        .doc(widget.id)
                        .update({'allowed': value});
                  });
                },
              )
            ],
          )),
    );
  }
}
