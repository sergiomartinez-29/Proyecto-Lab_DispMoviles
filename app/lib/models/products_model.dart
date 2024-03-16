// products_model.dart

class Product {
  final String id;
  final String name;
  final double price;
  final String size;
  final int stock;
  final String photoUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.size,
    required this.stock,
    required this.photoUrl,
  });
}
