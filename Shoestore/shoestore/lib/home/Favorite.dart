import 'package:flutter/material.dart';
import 'package:shoestore/test/NavigationBar.dart';
import 'package:shoestore/test/ProductListPage.dart';
import 'package:shoestore/test/CartPage.dart';

class FavoritePage extends StatelessWidget {
  final List<Product> favoriteProducts;
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  FavoritePage({
    required this.favoriteProducts,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: favoriteProducts.isEmpty
          ? Center(
              child: Text('No favorite products.'),
            )
          : ListView.builder(
              itemCount: favoriteProducts.length,
              itemBuilder: (context, index) {
                final product = favoriteProducts[index];
                String imageUrl = product.imagePath.startsWith('http')
                    ? product.imagePath
                    : 'http://10.21.30.85:8000${product.imagePath}';
                return ListTile(
                  leading: Image.network(imageUrl),
                  title: Text(product.title),
                  subtitle: Text('${product.price} VND'),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to CartPage
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CartPage(cart: []), // Pass the actual cart list
            ),
          );
        },
        child: Icon(
          Icons.shopping_bag,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
        elevation: 2.0,
        shape: CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: selectedIndex,
        onItemTapped: (index) {
          if (index == 0) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => ProductListPage(
                  username: 'username', // Replace with the actual username
                  token: 'token',       // Replace with the actual token
                  cart: [],             // Replace with the actual cart list
                  favoriteProducts: favoriteProducts,
                  products: [], // Pass the products list or fetch as needed
                  onItemTapped: (int value) {},
                ),
              ),
              (route) => false,
            );
          } else {
            onItemTapped(index);
          }
        },
      ),
    );
  }
}
