import 'package:flutter/material.dart';
import 'edit_dialogue.dart';

class DishButton extends StatelessWidget {
  final String id;
  final String imgUrl;
  final String resturants;
  final String dishName;
  final String price;
  final String des;
  const DishButton({
    Key? key, required this.dishName, required this.price, required this.resturants, required this.des, required this.imgUrl, required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return EditDialogue(dishName: dishName,price: price,resturants: resturants,des: des,imgUrl: imgUrl,id: id,);
              },
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Ink.image(
              image: NetworkImage(imgUrl),
              height: 150,
              width: 200,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: dishName+'\n',
                      style:
                      const TextStyle(color: Colors.black, fontSize: 12),
                    ),
                    TextSpan(
                        text: 'Rs'+price,
                        style: const TextStyle(
                            color: Colors.black, fontSize: 15)),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}