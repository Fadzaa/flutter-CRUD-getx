
class ProductModel {
  ProductModel({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
  });

  final String id;
  final String title;
  final String image;
  final String price;



  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"] ?? "",
    title: json["title"] ?? "",
    image: json["image"] ?? "",
    price: json["price"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": image,
    "price": price,
  };
}
