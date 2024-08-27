// product_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductService {
  static const String baseUrl = 'http://192.168.1.14:8000/api/products';

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products/'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}

class Product {
  final int id;
  final String title;
  final String imagePath;
  final String price;
  final String badge;
  final String description;

  Product({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.price,
    required this.badge,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      imagePath: json['imagePath'],
      price: json['price'],
      badge: json['badge'],
      description: json['description'],
    );
  }
}