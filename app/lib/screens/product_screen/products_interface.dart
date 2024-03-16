import 'package:app/models/products_model.dart';
import 'package:app/screens/product_screen/add_product_form.dart';
import 'package:flutter/material.dart';

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

  final List<Product> productos = [
    Product(
      id: '1',
      name: 'Producto 1',
      price: 10.0,
      size: 'M',
      stock: 5,
      photoUrl: 'https://images.pexels.com/photos/1028646/pexels-photo-1028646.jpeg?auto=compress&cs=tinysrgb&h=650&w=940',
    ),
    Product(
      id: '2',
      name: 'Producto 2',
      price: 20.0,
      size: 'L',
      stock: 8,
      photoUrl: 'https://th.bing.com/th/id/OIP.QRSMYfbckiJx8KDG5NzrMgHaHa?rs=1&pid=ImgDetMain',
    ),
    Product(
      id: '1',
      name: 'Producto 1',
      price: 10.0,
      size: 'M',
      stock: 5,
      photoUrl: 'https://www.wallpapertip.com/wmimgs/75-754668_android-wallpaper-goku-ssj3-with-hd-resolution-goku.jpg',
    ),
    Product(
      id: '2',
      name: 'Producto 2',
      price: 20.0,
      size: 'L',
      stock: 8,
      photoUrl: 'https://th.bing.com/th/id/R.eb1d0dc9ac97a6a7903f9a8f15f15e39?rik=tcWE%2bqmLWCow2g&riu=http%3a%2f%2fdata.1freewallpapers.com%2fdownload%2f3-cute-kittens.jpg&ehk=%2fYqrQL8Ji1RbDN2cMDTLWKkpI64SjbT%2bwwS8htZLfow%3d&risl=&pid=ImgRaw&r=0',
    ),
    Product(
      id: '3',
      name: 'Producto 3',
      price: 10.0,
      size: 'M',
      stock: 5,
      photoUrl: 'https://th.bing.com/th/id/OIP.QRSMYfbckiJx8KDG5NzrMgHaHa?rs=1&pid=ImgDetMain',
    ),
    Product(
      id: '4',
      name: 'Producto 4',
      price: 20.0,
      size: 'L',
      stock: 8,
      photoUrl: 'https://th.bing.com/th/id/OIP.QRSMYfbckiJx8KDG5NzrMgHaHa?rs=1&pid=ImgDetMain',
    ),
    Product(
      id: '1',
      name: 'Producto 1',
      price: 10.0,
      size: 'M',
      stock: 5,
      photoUrl: 'https://th.bing.com/th/id/OIP.QRSMYfbckiJx8KDG5NzrMgHaHa?rs=1&pid=ImgDetMain',
    ),
    Product(
      id: '2',
      name: 'Producto 2',
      price: 20.0,
      size: 'L',
      stock: 8,
      photoUrl: 'https://th.bing.com/th/id/OIP.QRSMYfbckiJx8KDG5NzrMgHaHa?rs=1&pid=ImgDetMain',
    ),
    Product(
      id: '3',
      name: 'Producto 3',
      price: 10.0,
      size: 'M',
      stock: 5,
      photoUrl: 'https://th.bing.com/th/id/OIP.QRSMYfbckiJx8KDG5NzrMgHaHa?rs=1&pid=ImgDetMain',
    ),
    Product(
      id: '4',
      name: 'Producto 4',
      price: 20.0,
      size: 'L',
      stock: 8,
      photoUrl: 'https://th.bing.com/th/id/OIP.QRSMYfbckiJx8KDG5NzrMgHaHa?rs=1&pid=ImgDetMain',
    ),
  ];

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
          return ProductoItem(producto: productos[index]);
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.all(16.0),
                child: AgregarProductoForm(
                  onProductoAdded: (nuevoProducto) {
                    setState(() {
                      productos.add(nuevoProducto);
                    });
                  },
                ),
              );
            },
          );
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
