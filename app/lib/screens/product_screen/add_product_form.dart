import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:app/models/products_model.dart'; // Importa el modelo de productos

class AgregarProductoForm extends StatefulWidget {
  final Function(Product) onProductoAdded;

  const AgregarProductoForm({Key? key, required this.onProductoAdded}) : super(key: key);

  @override
  _AgregarProductoFormState createState() => _AgregarProductoFormState();
}

class _AgregarProductoFormState extends State<AgregarProductoForm> {
  final _formKey = GlobalKey<FormState>();
  late String _barcode;
  late String _nombre;
  late double _precio;
  late String _size;
  late int _stock;

  @override
  void initState() {
    super.initState();
    _barcode = '';
    _nombre = '';
    _precio = 0.0;
    _size = '';
    _stock = 0;
  }

  Future<void> _scanBarcode() async {
    final barcode = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancelar', true, ScanMode.BARCODE);
    if (!mounted) return;
    setState(() {
      _barcode = barcode;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [/**/
          TextFormField(
            decoration: InputDecoration(labelText: 'ID del producto'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa el ID del producto';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _nombre = _barcode;
              });
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Nombre del producto'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa el nombre del producto';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _nombre = value;
              });
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Precio'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || double.tryParse(value) == null) {
                return 'Por favor ingresa un precio válido';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _precio = double.parse(value);
              });
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Tamaño'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa el tamaño del producto';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _size = value;
              });
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Stock'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || int.tryParse(value) == null) {
                return 'Por favor ingresa un valor válido para el stock';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _stock = int.parse(value);
              });
            },
          ),
          ElevatedButton(
            onPressed: _scanBarcode,
            child: Text('Escanear código de barras'),
          ),
          ElevatedButton(
            onPressed: (){},
            child: Text('Seleccionar imagen'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final nuevoProducto = Product(
                  id: _barcode,
                  name: _nombre,
                  price: _precio,
                  size: _size,
                  stock: _stock,
                  photoUrl: 'https://th.bing.com/th/id/OIP.QRSMYfbckiJx8KDG5NzrMgHaHa?rs=1&pid=ImgDetMain',
                );
                widget.onProductoAdded(nuevoProducto);
                Navigator.of(context).pop();
              }
            },
            child: Text('Agregar producto'),
          ),
        ],
      ),
    );
  }
}
