import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:technical_test1/model/ProductModel.dart';
import 'package:intl/intl.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    requestPermissions();
    _loadData();
  }

  Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
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

  Future<void> _loadData() async {
    // Add a delay of 2 seconds to simulate loading time
    await Future.delayed(Duration(seconds: 2));

    // Mock API response
    final List<Product> listProduct = [
      Product(
          id: "1",
          title: "ASUS ROG Zephyrus G15 Ryzen 9 6900HS RTX 3070TI",
          gambar:
          "https://images.tokopedia.net/img/cache/900/VqbcmM/2023/1/7/f672fb3d-eda2-4370-9e6a-20e7ce09cecd.png",
          isActive: 1,
          createTime: "2021-12-14 13:36:44",
          updateTime: "2021-12-14 13:37:44",
          price: "35149000"),
      Product(
          id: "2",
          title: "Leovo Yoga 6 2in1 Ryzen 7 7730U",
          gambar:
          "https://images.tokopedia.net/img/cache/900/VqbcmM/2023/4/5/88375814-e21b-482f-888d-fb1125bf6c2d.png",
          isActive: 1,
          createTime: "2021-12-14 13:37:44",
          updateTime: "2021-12-14 13:37:44",
          price: "14799000"),
      Product(
          id: "3",
          title: "MSI Modern 14 Ryzen 7 5825U",
          gambar:
          "https://images.tokopedia.net/img/cache/900/VqbcmM/2023/3/18/5406a2c7-d47b-4d28-ba45-4e244418c5e4.png",
          isActive: 1,
          createTime: "2021-12-14 13:38:44",
          updateTime: "2022-08-17 16:39:41",
          price: "9499000"),
      Product(
          id: "4",
          title: "DELL Gaming G15 Ryzen 7 5800H RTX 3050TI",
          gambar:
          "https://images.tokopedia.net/img/cache/900/VqbcmM/2023/1/11/89e42c0c-aa44-4447-b5b1-154dc05aad98.png",
          isActive: 1,
          createTime: "2021-12-14 13:39:44",
          updateTime: "2022-08-17 16:39:41",
          price: "13849000"),
      Product(
          id: "5",
          title: "HP 14S EM0014AU Ryzen 3 7320U",
          gambar:
          "https://images.tokopedia.net/img/cache/900/VqbcmM/2023/3/29/c82237ba-f253-4af7-a75b-393274704058.png",
          isActive: 0,
          createTime: "2021-12-14 13:40:44",
          updateTime: "2022-08-17 16:39:41",
          price: "6649000"),
      Product(
          id: "6",
          title: "ASUS ROG Strix G15 Ryzen 7 5800H RTX 3070",
          gambar:
          "https://images.tokopedia.net/img/cache/900/VqbcmM/2022/12/21/0c8d0030-315b-4400-94d1-3bebda5f80c2.png",
          isActive: 1,
          createTime: "2021-12-14 13:41:44",
          updateTime: "2022-08-17 16:39:41",
          price: "24049000"),
      Product(
          id: "7",
          title: "Lenovo Ideapad Gaming 3 Ryzen 7735HS RTX 4050",
          gambar:
          "https://images.tokopedia.net/img/cache/900/VqbcmM/2023/4/6/6628cf93-c366-4f63-879e-02a72eb9a431.png",
          isActive: 1,
          createTime: "2021-12-14 13:42:44",
          updateTime: "2022-08-17 16:39:41",
          price: "19399000"),
    ];

    final productReady = listProduct.where((product) => product.isActive != 0).toList();

    final NumberFormat formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');

    final List<Product> formattedProducts = productReady.map((product) {
      final formattedPrice = formatCurrency.format(double.parse(product.price));
      return Product(
        id: product.id,
        title: product.title,
        gambar: product.gambar,
        isActive: product.isActive,
        createTime: product.createTime,
        updateTime: product.updateTime,
        price: formattedPrice
      );
    }).toList();



    setState(() {
      products = formattedProducts;
      isLoading = false;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Technical Test 1"),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return FutureBuilder<bool>(
            future: checkInternetConnectivity(),
            builder: (context, snapshot) {
              final product = products[index];
              final DateFormat dateFormat = DateFormat('MMM d, y');
              final DateFormat timeFormat = DateFormat.jm();

              String formattedCreateTime = '${dateFormat.format(DateTime.parse(products[index].createTime))} at ${timeFormat.format(DateTime.parse(products[index].createTime))}';
              String formattedUpdateTime = '${dateFormat.format(DateTime.parse(products[index].updateTime))} at ${timeFormat.format(DateTime.parse(products[index].updateTime))}';
              if (snapshot.hasData && snapshot.data == true) {
                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeInImage(
                          placeholder: AssetImage("assets/placeholder/dummy_600x400_ffffff_cccccc.png"),
                          image: NetworkImage(products[index].gambar),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 110,
                        ),
                        Text(product.title,style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),),
                        Text('ID: ${product.id}',style: TextStyle(fontSize: 7),),
                        Text('Create Time: ${formattedCreateTime}',style : TextStyle(fontSize: 8)),
                        Text('Update Time: ${formattedUpdateTime}',style : TextStyle(fontSize: 8)),
                        Text('Price: ${product.price}',style : TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                );
              } else {
                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/placeholder/dummy_600x400_ffffff_cccccc.png",
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 110,
                        ),
                        Text(product.title,style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),),
                        Text('ID: ${product.id}',style: TextStyle(fontSize: 7),),
                        Text('Create Time: ${formattedCreateTime}',style : TextStyle(fontSize: 8)),
                        Text('Update Time: ${formattedUpdateTime}',style : TextStyle(fontSize: 8)),
                        Text('Price: ${product.price}',style : TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                );
              }
            },
          );
        },
      )


    );
  }
}




