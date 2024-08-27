import 'package:flutter/material.dart';
import 'package:shoestore/home/HomePage.dart';
import 'package:shoestore/auth/login.dart';
import 'package:shoestore/auth/register.dart';
import 'package:shoestore/test/ProductListPage.dart';
import 'package:shoestore/test/ShoeStorePage.dart';
import 'package:shoestore/test/paypal.dart';
import 'main_screen.dart';

void main() async {
  // ignore: unused_label
  debugShowCheckedModeBanner: false;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/login': (context) => LoginPage(),
        '/': (context) => ShoeStorePage(),
        '/productListPage': (context) => ProductListPage(username: '', token: '', cart: [], favoriteProducts: [], products: [], onItemTapped: (int value) {  },), // Define the route
      },
    );
  }
}
