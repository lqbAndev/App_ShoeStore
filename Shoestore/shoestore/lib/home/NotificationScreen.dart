import 'package:flutter/material.dart';
import 'package:shoestore/test/NavigationBar.dart';
import 'package:shoestore/test/ProductListPage.dart'; // Đảm bảo đường dẫn đúng với cấu trúc dự án của bạn
import 'package:shoestore/test/CartPage.dart'; // Đảm bảo đường dẫn đúng với cấu trúc dự án của bạn

class NotificationPage extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  NotificationPage({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  void _navigateToCart(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartPage(cart: []), // Thay thế bằng danh sách giỏ hàng thực tế
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thông báo"),
        backgroundColor: Color.fromARGB(255, 255, 250, 250),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Section(title: "Hôm nay", products: [
              Product(
                imageUrl: 'images/Nike_2.png',
                name: 'Sản phẩm đang giảm giá',
                oldPrice: 4500000,
                newPrice: 2300000,
              ),
              Product(
                imageUrl: 'images/puma_2.png',
                name: 'Sản phẩm đang giảm giá',
                oldPrice: 5000000,
                newPrice: 1900000,
              ),
            ]),
            Section(title: "Vài ngày trước", products: [
              Product(
                imageUrl: 'images/puma_3.png',
                name: 'Sản phẩm đang giảm giá',
                oldPrice: 4000000,
                newPrice: 1750000,
              ),
              Product(
                imageUrl: 'images/adidas_1.png',
                name: 'Sản phẩm đang giảm giá',
                oldPrice: 3500000,
                newPrice: 2400000,
              ),
            ]),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToCart(context),
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
                  username: 'username', // Thay thế bằng username thực tế
                  token: 'token',       // Thay thế bằng token thực tế
                  cart: [],             // Thay thế bằng danh sách giỏ hàng thực tế
                  favoriteProducts: [],// Thay thế bằng danh sách sản phẩm yêu thích thực tế
                  products: [],         // Thay thế bằng danh sách sản phẩm thực tế hoặc fetch khi cần
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

class Section extends StatelessWidget {
  final String title;
  final List<Product> products;

  Section({required this.title, required this.products});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ...products.map((product) => ProductCard(product: product)).toList(),
      ],
    );
  }
}

class Product {
  final String imageUrl;
  final String name;
  final int oldPrice;
  final int newPrice;

  Product({
    required this.imageUrl,
    required this.name,
    required this.oldPrice,
    required this.newPrice,
  });
}

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Image.asset(
            product.imageUrl,
            width: 80,
            height: 80,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '${product.oldPrice}đ',
                  style: TextStyle(
                    fontSize: 14,
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  '${product.newPrice}đ',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
