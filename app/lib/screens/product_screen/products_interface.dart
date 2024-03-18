//products_interface.dart
import 'package:app/screens/product_screen/edit_product_form.dart';
import 'package:app/screens/product_screen/add_product_form.dart';
import 'package:flutter/material.dart';
import 'package:app/models/products_model.dart';

class Productos extends StatelessWidget {
  const Productos({Key? key});

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
  final String title;

  const ListaDeProductos({Key? key, required this.title}) : super(key: key);

  @override
  State<ListaDeProductos> createState() => _ListaDeProductos();
}

class _ListaDeProductos extends State<ListaDeProductos> {
  final List<Product> productos = [];

  @override
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
          photoUrl:
              'https://th.bing.com/th/id/OIP.QRSMYfbckiJx8KDG5NzrMgHaHa?rs=1&pid=ImgDetMain',
        ),
      );
    }
  }

  Future<void> _showEditProductModal(Product product) async {
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return EditProductForm(
          product: product, 
        ); // Usa el formulario de edición de productos
      },
    );
    setState(() {});
  }

  void _showAddProductForm() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return AddProductForm(
          onProductAdded: (newProduct) {
            setState(() {
              productos.add(newProduct);
            });
          },
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
        onPressed: _showAddProductForm,
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
            aspectRatio: 16 / 9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                producto.photoUrl,
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                  return Container(
                    color: Colors.grey, // Color de fondo de la imagen de reemplazo
                    child: Center(
                      child: Text(
                        'Imagen no disponible',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  producto.name,
                  style: Theme.of(context).textTheme.headline6,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  '\$${producto.price.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
