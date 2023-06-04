import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddProductController extends GetxController {
  TextEditingController cName = TextEditingController();
  TextEditingController cPrice = TextEditingController();
  TextEditingController cDescription = TextEditingController();

  RxString fullName = "".obs;
  Rx<String> imagePath = Rx<String>('');
  RxBool isGuest = RxBool(false);
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final currentUser = FirebaseAuth.instance.currentUser;




  Future<void> pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      imagePath.value = pickedImage.path;
    }
  }




  Future<Map<String, dynamic>> addProduct(Map<String, dynamic> data, String imageUrl) async {
    try {
      var result = await firestore.collection("products").add(data);
      await firestore.collection("products").doc(result.id).update({
        "productId": result.id,
        "imageUrl": imageUrl
      });

      return {
        "error": false,
        "message": "Sukses menambah product."
      };
    } catch (e) {
      print(e);
      return {
        "error": true,
        "message": "Tidak dapat menambah product. ${e}"
      };
    }
  }


  Future<String?> uploadImageToFirebaseStorage(String imagePath) async {
    try {
      final file = File(imagePath);
      final fileName = file.path.split('/').last;
      final destination = 'images/$fileName';

      final ref = firebase_storage.FirebaseStorage.instance.ref(destination);
      await ref.putFile(file);

      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      print(e);
      return null;
    }
  }







  void fetchFullName(String userId) async {
    if (userId != null) {
      var snapshot = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      if (snapshot.exists) {
        fullName.value = snapshot.data()?['fullName'] ?? "Guest";
      } else {
        fullName.value = "Guest";
      }
    }
  }
}



