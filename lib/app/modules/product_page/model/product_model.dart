
class ProductModel {
  ProductModel({
    required this.id,
    required this.title,
    required this.mentor,
    required this.image,
    required this.price,
    required this.description
  });

  final String id;
  final String title;
  final String mentor;
  final String image;
  final int price;
  final String description;



  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["productId"] ?? "",
    title: json["title"] ?? "",
    mentor: json["mentor"] ?? "",
    image: json["imageUrl"] ?? "",
    price: json["price"] ?? 0,
    description: json["description"] ?? ""
  );

  Map<String, dynamic> toJson() => {
    "productId": id,
    "title": title,
    "imageUrl": image,
    "price": price,
    "mentor": mentor,
    "description": description
  };
}
