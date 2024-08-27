import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shoestore/test/ProductListPage.dart';


Future<List<Product>> fetchNotificationProducts() async {
  final response = await http.get(Uri.parse('http://10.21.30.85:8000/api/notifications/'));

  if (response.statusCode == 200) {
    List<dynamic> body = jsonDecode(response.body);
    return body.map((dynamic item) => Product.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load notifications');
  }
}