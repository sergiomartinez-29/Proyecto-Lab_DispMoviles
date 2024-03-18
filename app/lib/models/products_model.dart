// products_model.dart

class Product {
  late String id;
  late String name;
  late double price;
  late String size;
  late int stock;
  late String photoUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.size,
    required this.stock,
    required this.photoUrl,
  });
}
