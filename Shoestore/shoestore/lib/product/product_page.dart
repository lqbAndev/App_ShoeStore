// product_page.dart
import 'package:flutter/material.dart';
import 'package:shoestore/product/Product.dart';


class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = ProductService().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: FutureBuilder<List<Product>>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].title),
                  subtitle: Text(snapshot.data![index].price),
                  leading: Image.network(snapshot.data![index].imagePath),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load products'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}