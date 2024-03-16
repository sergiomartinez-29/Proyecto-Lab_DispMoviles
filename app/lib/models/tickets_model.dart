
// tickets_model.dart

import 'package:app/models/customers_model.dart';
import 'package:app/models/products_model.dart';

class Ticket {
  final String id;
  final Customer customer;
  final List<Product> products;
  final DateTime timestamp;

  Ticket({
    required this.id,
    required this.customer,
    required this.products,
    required this.timestamp,
  });
}