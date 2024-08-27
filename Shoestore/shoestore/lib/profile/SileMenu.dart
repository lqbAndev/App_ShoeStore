import 'package:flutter/material.dart';
import 'package:shoestore/home/HomePage.dart';

import 'package:shoestore/profile/proflie.dart';
import 'package:shoestore/test/ProductListPage.dart';
import 'package:shoestore/auth/login.dart'; // Import trang login

class ProfileScreen extends StatelessWidget {
  final String username;

  ProfileScreen({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('images/avata.jpg'), // Replace with your image path
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Xin chào, 👋',
                        style: TextStyle(color: Colors.black54, fontSize: 16),
                      ),
                      Text(
                        'Welcome, $username!',
                        style: TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 50),
              Column(
                children: [
                  _buildMenuItem(Icons.person_outline, 'Trang cá nhân', () {
                    // Navigate to profile screen
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Profile_Screen()));
                  }),
                  SizedBox(height: 10.0),
                  _buildMenuItem(Icons.home_outlined, 'Trang chủ', () {
                    // Navigate to home screen
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProductListPage(username: username, token: '', cart: [], favoriteProducts: [], products: [], onItemTapped: (int value) {  },)));
                  }),
                  SizedBox(height: 10.0),
                  _buildMenuItem(Icons.shopping_bag_outlined, 'Giỏ hàng của tôi', () {
                    // Navigate to shopping cart screen
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => ShoppingCartScreen()));
                  }),
                  SizedBox(height: 10.0),
                  _buildMenuItem(Icons.favorite_border, 'Mục yêu thích', () {
                    // Navigate to favorites screen
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritesScreen()));
                  }),
                  SizedBox(height: 10.0),
                  _buildMenuItem(Icons.local_shipping_outlined, 'Theo dõi đơn hàng', () {
                    // Navigate to order tracking screen
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => OrderTrackingScreen()));
                  }),
                  
                  Divider(color: Colors.black54),
                  SizedBox(height: 10.0),
                  _buildMenuItem(Icons.logout, 'Đăng xuất', () {
                    // Navigate to login screen
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()), // Chuyển hướng đến trang đăng nhập
                    );
                  }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: onPressed,
        child: Row(
          children: [
            Icon(icon, color: Colors.black54),
            SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(color: Colors.black87, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
