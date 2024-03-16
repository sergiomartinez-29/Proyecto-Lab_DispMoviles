import 'package:app/screens/product_screen/products_interface.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: ListaDeProductos(title: 'Registro de productos'),
    );
  }
}