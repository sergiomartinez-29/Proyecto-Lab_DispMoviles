//edit_product_form.dart
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:app/models/products_model.dart';
import 'package:flutter/services.dart';
//import 'package:app/screens/product_screen/products_interface.dart';

class EditProductForm extends StatefulWidget {
  final Product product;

  const EditProductForm({Key? key, required this.product}) : super(key: key);

  @override
  _EditProductFormState createState() => _EditProductFormState();
}

class _EditProductFormState extends State<EditProductForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String newID;
  late String newName;
  late double newPrice;
  late String newSize;
  late int newStock;
  late String newPhotoUrl;

  @override
  void initState() {
    super.initState();
    newID = widget.product.id;
    newName = widget.product.name;
    newPrice = widget.product.price;
    newSize = widget.product.size;
    newStock = widget.product.stock;
    newPhotoUrl = widget.product.photoUrl;
  }
  
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
                'Editar Producto',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 16.0),
              
              TextFormField(
                initialValue: newID,
                decoration: InputDecoration(labelText: 'ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce el ID del producto';
                  }
                  return null;
                },
                onSaved: (value) {
                  newID = value!;
                  setState(() {});
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                initialValue: newName,
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce el nombre del producto';
                  }
                  return null;
                },
                onSaved: (value) {
                  newName = value!;
                },
              ),
              TextFormField(
                initialValue: newPrice.toString(),
                decoration: InputDecoration(labelText: 'Precio'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce el precio del producto';
                  }
                  return null;
                },
                onSaved: (value) {
                  newPrice = double.tryParse(value!) ?? 0.0;
                },
              ),
              TextFormField(
                initialValue: newSize,
                decoration: InputDecoration(labelText: 'Tamaño'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce el tamaño del producto';
                  }
                  return null;
                },
                onSaved: (value) {
                  newSize = value!;
                },
              ),
              TextFormField(
                initialValue: newStock.toString(),
                decoration: InputDecoration(labelText: 'Stock'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce el stock del producto';
                  }
                  return null;
                },
                onSaved: (value) {
                  newStock = int.tryParse(value!) ?? 0;
                },
              ),
              TextFormField(
                initialValue: newPhotoUrl,
                decoration: InputDecoration(labelText: 'URL de la Foto'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce la URL de la foto del producto';
                  }
                  return null;
                },
                onSaved: (value) {
                  newPhotoUrl = value!;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  print('Valor del ID escaneado: $newID');
                  String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                    '#FF0000', // Color de la línea de escaneo
                    'Cancelar', // Texto del botón de cancelar
                    true, // Muestra un botón de flash
                    ScanMode.BARCODE, // Tipo de escaneo (código de barras)
                  );

                  if (barcodeScanRes != '-1') {
                    // Si el usuario no canceló el escaneo, actualiza el ID del producto
                    Clipboard.setData(ClipboardData(text: barcodeScanRes));
                  }
                },
                child: Text('Escanear Código de Barras'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    widget.product.id = newID;
                    widget.product.name = newName;
                    widget.product.price = newPrice;
                    widget.product.size = newSize;
                    widget.product.stock = newStock;
                    widget.product.photoUrl = newPhotoUrl;
                    Navigator.of(context).pop();
                    setState(() {});
                  }
                },
                child: Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  
}
