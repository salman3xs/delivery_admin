import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_admin/Pages/Home/Pages/CakeShops/Cakes/cake_page.dart';
import 'package:flutter/material.dart';
import 'package:delivery_admin/constants.dart';
import 'Components/app_bar.dart';

class CakeShopPage extends StatefulWidget {
  const CakeShopPage({Key? key}) : super(key: key);
  @override
  State<CakeShopPage> createState() => _CakeShopPageState();
}

class _CakeShopPageState extends State<CakeShopPage> {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kYellow,
      appBar: CakeAppBar(),
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
                      'CAKE SHOPS',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                ), // Popular Resturants Text
                FutureBuilder<QuerySnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('cake_shop')
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
                                id: snapshot.data!.docs[index].id,
                                allowed: snapshot.data!.docs[index].get('allowed'),
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
  bool allowed;
  final String id;
  final String name;
  final String address;

  ResturantsButton(
      {Key? key,
      required this.name,
      required this.address,
      required this.id,
      required this.allowed})
      : super(key: key);

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
                    builder: (BuildContext context) => CakesPage(
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
                        .collection('cake_shop')
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
