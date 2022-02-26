import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:delivery_admin/constants.dart';
import 'package:image_picker/image_picker.dart';

class AddCake extends StatefulWidget {
  final String resturants;

  AddCake({Key? key, required this.resturants}) : super(key: key);

  @override
  State<AddCake> createState() => _AddCakeState();
}

class _AddCakeState extends State<AddCake> {
  final TextEditingController cakeNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  PickedFile? img;
  int pick = 0;

  final snackBar = const SnackBar(
    content: Text(
      'CakeShops Added',
      style: TextStyle(color: kTextColor),
    ),
    backgroundColor: kYellow,
  );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: kYellow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
            InputBar(
                controller: descriptionController,
                preicon: Icons.info,
                hint: 'Description',
                input: TextInputType.text),
            pick == 0
                ? IconButton(
                    iconSize: 50,
                    onPressed: () async {
                      await imgPick();
                    },
                    icon: const Icon(
                      Icons.add_a_photo,
                      color: kRed,
                    ),
                  )
                : Image.file(File(img!.path)),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(kRed),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)))),
                  onPressed: () async {
                    await upload();
                  },
                  child: const Text(
                    'Add CakeShops',
                    style: TextStyle(color: Colors.white),
                  )),
            )
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
  Future upload() async {
    if (pick == 1) {
      Reference ref = FirebaseStorage.instance.ref();
      TaskSnapshot addImg = await ref.child(img!.path).putFile(File(img!.path));
      if (addImg.state == TaskState.success) {
        final String url = await addImg.ref.getDownloadURL();
        FirebaseFirestore.instance.collection('cake').add({
          'name': cakeNameController.text,
          'price': priceController.text,
          'des': descriptionController.text,
          'resturants': widget.resturants,
          'imgUrl': url
        });
      }
    } else {
      FirebaseFirestore.instance.collection('cake').add({
        'name': cakeNameController.text,
        'price': priceController.text,
        'des': descriptionController.text,
        'resturants': widget.resturants,
        'imgUrl': 'no'
      });
    }
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
