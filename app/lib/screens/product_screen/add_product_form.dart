import 'package:flutter/material.dart';
import 'package:app/models/products_model.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';

class AddProductForm extends StatefulWidget {
  final Function(Product) onProductAdded;

  const AddProductForm({Key? key, required this.onProductAdded}) : super(key: key);

  @override
  _AddProductFormState createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String id;
  late String name;
  late double price;
  late String size;
  late int stock;
  late String photoUrl;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Agregar Producto',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(labelText: 'ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce el ID del producto';
                  }
                  return null;
                },
                onSaved: (value) {
                  id = value!;
                },
              ),
              SizedBox(height: 16.0),
              // Resto de los campos del formulario (Nombre, Precio, Tamaño, Stock, URL de la foto)
              // Similar al formulario de edición de productos
              // ...
              TextFormField(
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce el nombre del producto';
                  }
                  return null;
                },
                onSaved: (value) {
                  name = value!;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(labelText: 'Precio'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce el ID del producto';
                  }
                  return null;
                },
                onSaved: (value) {
                  price = double.tryParse(value!) ?? 0.0;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(labelText: 'Tamaño'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce el ID del producto';
                  }
                  return null;
                },
                onSaved: (value) {
                  size = value!;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(labelText: 'Stock'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce el ID del producto';
                  }
                  return null;
                },
                onSaved: (value) {
                  stock = int.tryParse(value!) ?? 0;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(labelText: 'Url'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce el ID del producto';
                  }
                  return null;
                },
                onSaved: (value) {
                  photoUrl = value!;
                },
              ),
              SizedBox(height: 16.0),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                    '#FF0000', // Color de la línea de escaneo
                    'Cancelar', // Texto del botón de cancelar
                    true, // Muestra un botón de flash
                    ScanMode.BARCODE, // Tipo de escaneo (código de barras)
                  );

                  if (barcodeScanRes != '-1') {
                    // Si el usuario no canceló el escaneo, actualiza el ID del producto
                    setState(() {
                      id = barcodeScanRes;
                      Clipboard.setData(ClipboardData(text: barcodeScanRes));
                    });
                  }
                },
                child: Text('Escanear Código de Barras'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final newProduct = Product(
                      id: id,
                      name: name,
                      price: price,
                      size: size,
                      stock: stock,
                      photoUrl: photoUrl,
                    );
                    widget.onProductAdded(newProduct);
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Agregar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
