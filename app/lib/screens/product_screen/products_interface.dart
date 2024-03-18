import 'package:app/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class Productos extends StatelessWidget {
  const Productos({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Productos',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const ListaDeProductos(title: 'Registro de productos'),
    );
  }
}

class ListaDeProductos extends StatefulWidget {
  const ListaDeProductos({super.key, required this.title});

  final String title;

  @override
  State<ListaDeProductos> createState() => _ListaDeProductos();
}

class _ListaDeProductos extends State<ListaDeProductos> {

  final List<Product> productos = [];
  void initState() {
    super.initState();
    // Agrega los productos al iniciar el estado
    for (int i = 1; i <= 11; i++) {
      productos.add(
        Product(
          id: i.toString(),
          name: 'Producto $i',
          price: 10.0 * i,
          size: 'M',
          stock: 5 * i,
          photoUrl: 'https://th.bing.com/th/id/OIP.QRSMYfbckiJx8KDG5NzrMgHaHa?rs=1&pid=ImgDetMain',
        ),
      );
    }
  }
  /**/
  void _showEditProductModal(Product product) {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? newID = product.id;
  String? newName = product.name;
  double? newPrice = product.price;
  String? newSize = product.size;
  int? newStock = product.stock;
  String? newPhotoUrl = product.photoUrl;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
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
                    initialValue: newID ?? product.id,
                    decoration: InputDecoration(labelText: 'ID'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, introduce el ID del producto';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      newID = value;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    initialValue: product.name,
                    decoration: InputDecoration(labelText: 'Nombre'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, introduce el nombre del producto';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      newName = value;
                    },
                  ),
                  TextFormField(
                    initialValue: product.price.toString(),
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
                    initialValue: product.size,
                    decoration: InputDecoration(labelText: 'Tamaño'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, introduce el tamaño del producto';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      newSize = value;
                    },
                  ),
                  TextFormField(
                    initialValue: product.stock.toString(),
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
                    initialValue: product.photoUrl,
                    decoration: InputDecoration(labelText: 'URL de la Foto'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, introduce la URL de la foto del producto';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      newPhotoUrl = value;
                    },
                  ),
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
                          product.id = barcodeScanRes;
                        });
                      }
                    },
                    child: Text('Escanear Código de Barras'),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        product.id = newID!;
                        product.name = newName!;
                        product.price = newPrice!;
                        product.size = newSize!;
                        product.stock = newStock!;
                        product.photoUrl = newPhotoUrl!;
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),

      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Muestra dos columnas
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: productos.length,
        itemBuilder: (BuildContext context, int index) {
          // Construye cada elemento del GridView
          return GestureDetector(
            onTap: () {
              _showEditProductModal(productos[index]);
            },
            child: ProductoItem(producto: productos[index]),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class ProductoItem extends StatelessWidget {
  final Product producto;
  const ProductoItem({Key? key, required this.producto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9, // Ajusta el aspect ratio según tu necesidad
            child: Image.network(
              producto.photoUrl,
              fit: BoxFit.cover, // Ajusta el tamaño de la imagen para cubrir todo el espacio disponible
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  producto.name,
                  style: Theme.of(context).textTheme.titleLarge,
                  overflow: TextOverflow.ellipsis, // Trunca el texto si es demasiado largo
                ),
                SizedBox(height: 4), // Espacio entre el nombre y el precio
                Text(
                  '\$${producto.price.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
