import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsProductController extends GetxController {
  TextEditingController cName = TextEditingController();
  TextEditingController cPrice = TextEditingController();
  TextEditingController cDescription = TextEditingController();



  RxBool isTextFieldVisible = false.obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final currentUser = FirebaseAuth.instance.currentUser;


  //Display TextField
  void toggleTextFieldVisibility() {
    isTextFieldVisible.value = !isTextFieldVisible.value;
  }


  //Update Logic
  Future<Map<String, dynamic>> updateProduct(Map<String, dynamic> data) async {
    try {
      var result = await firestore.collection("products").doc(data["id"]).update(
          {
            "title":data["title"],
            "price":data["price"],
            "description":data["description"]
          }
      );


      return {
        "error": false,
        "message": "Sukses update product."
      };
    } catch (e) {
      print(e);
      return {
        "error": true,
        "message": "Tidak dapat update product."
      };
    }

  }

  //Delete Logic
  Future<Map<String,dynamic>> deleteProduct(String id) async {
    try{
      await firestore.collection("products").doc(id).delete();

      return {
        "error": false,
        "message": "Sukses hapus product."
      };

    }catch(e){
      print(e);
      return {
        "error": true,
        "message": "Tidak dapat menghapus product."
      };
    }
  }


}
