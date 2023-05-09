import 'package:permission_handler/permission_handler.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ProductPageController extends GetxController {
  //TODO: Implement ProductPageController

  var products = [].obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

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

  @override
  void onInit() {
    super.onInit();
    requestPermissions();
  }

}
