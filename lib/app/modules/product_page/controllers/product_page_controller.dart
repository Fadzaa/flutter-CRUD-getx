import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:technical_test1/helpers/themes.dart';
import '../../../routes/app_pages.dart';

class ProductPageController extends GetxController {


  RxList products = [].obs;
  RxString fullName = "".obs;
  RxBool isGuest = RxBool(false);
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  final currentUser = FirebaseAuth.instance.currentUser;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamProducts() async* {
    yield* firestore.collection("products").snapshots();
  }

  Future<void> requestPermissions() async {
    PermissionStatus gpsPermissionStatus = await Permission.location.request();
    if (gpsPermissionStatus.isDenied) {}

    PermissionStatus storagePermissionStatus =
    await Permission.storage.request();
    if (storagePermissionStatus.isDenied) {}

    final directory = await getApplicationDocumentsDirectory();
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
  }

  Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }

  Timer? _sessionTimer;

  void startSessionTimer() {
    _sessionTimer = Timer(Duration(seconds: 60), () {
      signOut();
    });
  }

  void resetSessionTimer() {
    _sessionTimer?.cancel();
    startSessionTimer();
  }

  void signOut() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 352,
          height: 216,
          padding: const EdgeInsets.symmetric(horizontal: 7.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.0),
              Text(
                'Session Timeout',
                style: dialogText(isTextDescription: false)
              ),
              SizedBox(height: 18.0),
              Text(
                'You have been signed out due to inactivity. Please re-login.',
                textAlign: TextAlign.center,
                style: dialogText(isTextDescription: true)),
              SizedBox(height: 35.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
                ),
                  onPressed: () {
                    Get.offAllNamed(Routes.LOGIN_PAGE);
                  },
                  child: Text('Continue', style: sessionButtonText),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
    auth.signOut();
  }

  @override
  void onInit() {
    super.onInit();
    requestPermissions();


    startSessionTimer();
    // Listen for user interactions
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      SchedulerBinding.instance!.addPersistentFrameCallback((_) {
        resetSessionTimer();
      });
    });

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



  @override
  void onClose() {
    _sessionTimer?.cancel();
    super.onClose();
  }


}
