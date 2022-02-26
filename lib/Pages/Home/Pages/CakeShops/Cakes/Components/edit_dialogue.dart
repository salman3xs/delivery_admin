import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:delivery_admin/constants.dart';
import 'package:image_picker/image_picker.dart';

class EditDialogue extends StatefulWidget {
  final String imgUrl;
  final String id;
  final String des;
  final String cakeName;
  final String price;
  final String resturants;

  const EditDialogue({
    Key? key,
    required this.cakeName,
    required this.price,
    required this.resturants,
    required this.des,
    required this.id,
    required this.imgUrl,
  }) : super(key: key);

  @override
  State<EditDialogue> createState() => _EditDialogueState();
}

class _EditDialogueState extends State<EditDialogue> {
  TextEditingController cakeNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController desController = TextEditingController();
  final snackBar = const SnackBar(
    content: Text(
      'CakeShops Edit',
      style: TextStyle(color: kTextColor),
    ),
    backgroundColor: kYellow,
  );
  PickedFile? img;
  int pick = 0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: kYellow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InputBar(
                controller: cakeNameController,
                preicon: Icons.fastfood,
                hint: 'Dish Name',
                input: TextInputType.text),
            InputBar(
                controller: priceController,
                preicon: Icons.monetization_on,
                hint: 'Price',
                input: TextInputType.number),
            pick == 0
                ? ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(kRed)),
                    child: Image.network(
                      widget.imgUrl,
                      height: 150,
                      width: 150,
                    ),
                    onPressed: () async {
                      await imgPick();
                    },
                  )
                : ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(kRed)),
                    onPressed: () async {
                      await imgPick();
                    },
                    child: Image.file(
                      File(img!.path),
                      height: 150,
                      width: 150,
                    ),
                  ),
            InputBar(
                controller: desController,
                preicon: Icons.info,
                hint: 'Des',
                input: TextInputType.text),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: IconButton(
                    iconSize: 40,
                    icon: Icon(Icons.save,color: kRed,),
                      onPressed: () async{
                        await save();
                      },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: IconButton(
                    iconSize: 40,
                      icon: const Icon(Icons.delete,color: kRed,),
                      onPressed: () async{
                        await del();
                      },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future imgPick() async {
    // ignore: invalid_use_of_visible_for_testing_member
    img = await ImagePicker.platform.pickImage(
      source: ImageSource.gallery,
    );
    if (img!.path != null) {
      setState(() {
        pick = 1;
      });
    }
  }
  Future save() async {
    if (pick == 1) {
      Reference ref = FirebaseStorage.instance.ref();
      TaskSnapshot addImg = await ref.child(img!.path).putFile(File(img!.path));
      if (addImg.state == TaskState.success) {
        final String url = await addImg.ref.getDownloadURL();
        FirebaseFirestore.instance.collection('cake').doc(widget.id).update({
          'name': cakeNameController.text,
          'price': priceController.text,
          'des': desController.text,
          'resturants': widget.resturants,
          'imgUrl': url
        });
      }
    } else {
      FirebaseFirestore.instance.collection('cake').doc(widget.id).update({
        'name': cakeNameController.text,
        'price': priceController.text,
        'des': desController.text,
        'resturants': widget.resturants,
      });
    }
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  Future del()async{
    await FirebaseFirestore.instance.collection('cake').doc(widget.id).delete();
    Navigator.pop(context);
  }
}

class InputBar extends StatelessWidget {
  const InputBar({
    Key? key,
    required this.controller,
    required this.preicon,
    required this.hint,
    required this.input,
  }) : super(key: key);
  final TextInputType input;
  final IconData preicon;
  final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        keyboardType: input,
        controller: controller,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintStyle: const TextStyle(color: kRed),
            hintText: hint,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(
                width: 1.0,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(
                width: 1.0,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(
                width: 1.0,
              ),
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: kRed,
                child: Icon(
                  preicon,
                  color: Colors.white,
                ),
              ),
            )),
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'Please Fill';
          }
          return null;
        },
      ),
    );
  }
}
