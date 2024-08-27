import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shoestore/test/ProductListPage.dart';


class OrderDetailPage extends StatefulWidget {
  final int orderId;

  OrderDetailPage({required this.orderId});

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  late Future<Order> _futureOrder;

  @override
  void initState() {
    super.initState();
    _futureOrder = _fetchOrderDetails(widget.orderId);
  }

  Future<Order> _fetchOrderDetails(int orderId) async {
    final response = await http.get(
      Uri.parse('http://10.21.30.85:8000/api/orders/$orderId/'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Order.fromJson(data);
    } else {
      throw Exception('Failed to load order details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết đơn hàng'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => ProductListPage(username: '', token: '', cart: [], favoriteProducts: [], products: [], onItemTapped: (int value) {  }, )),
              (Route<dynamic> route) => false,
            );
          },
        ),
      ),
      body: FutureBuilder<Order>(
        future: _futureOrder,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Order not found'));
          } else {
            final order = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ID đơn hàng: ${order.id}', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
                  Text('Ngày tạo: ${order.createdAt}', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
                  Text('Địa chỉ: ${order.address}', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
                  Text('Phương thức thanh toán: ${order.paymentMethod}', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
                  Text('Tổng tiền: ${order.total.toStringAsFixed(0)} VND', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  // Bạn có thể thêm chi tiết đơn hàng ở đây nếu cần
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => ProductListPage(username: '', token: '', cart: [], favoriteProducts: [], products: [], onItemTapped: (int value) {  }, )),
            (Route<dynamic> route) => false,
          );
        },
        child: Icon(Icons.arrow_back),
      ),
    );
  }
}

class Order {
  final int id;
  final String address;
  final String paymentMethod;
  final double total;
  final String createdAt;
  // Nếu bạn không cần sản phẩm, có thể loại bỏ trường items
  // final List<OrderItem> items;

  Order({
    required this.id,
    required this.address,
    required this.paymentMethod,
    required this.total,
    required this.createdAt,
    // required this.items,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      address: json['address'],
      paymentMethod: json['payment_method'],
      total: double.tryParse(json['total'].toString()) ?? 0.0,
      createdAt: json['created_at'],
      // items: List<OrderItem>.from(json['items'].map((item) => OrderItem.fromJson(item))),
    );
  }
}

// class OrderItem {
//   final Product product;
//   final int quantity;
//   final double price;

//
