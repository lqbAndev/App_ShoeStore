import 'package:flutter/material.dart';
import 'package:shoestore/test/Checkout_page.dart';
import 'package:shoestore/test/ProductListPage.dart';
import 'package:shoestore/test/paypal.dart';

class CartPage extends StatefulWidget {
  final List<Map<String, dynamic>> cart;

  CartPage({required this.cart});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void _increaseQuantity(int index) {
    setState(() {
      widget.cart[index]['quantity'] = (widget.cart[index]['quantity'] ?? 0) + 1;
    });
  }

  void _decreaseQuantity(int index) {
    setState(() {
      if ((widget.cart[index]['quantity'] ?? 1) > 1) {
        widget.cart[index]['quantity']--;
      }
    });
  }

  void _removeItem(int index) {
    setState(() {
      widget.cart.removeAt(index);
    });
  }

  double _calculateTotal() {
    return widget.cart.fold(0, (sum, item) {
      final quantity = item['quantity'] ?? 1;
      final price = item['product'].price ?? 0;
      return sum + (quantity * price);
    });
  }

  void _navigateToCheckout() {
    final total = _calculateTotal();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutPage(total: total, cart: [],),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final total = _calculateTotal();

    return Scaffold(
      appBar: AppBar(
        title: Text('Giỏ Hàng'),
      ),
      body: widget.cart.isEmpty
          ? Center(
              child: Text('Giỏ hàng của bạn đang trống'),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.cart.length,
                    itemBuilder: (context, index) {
                      final item = widget.cart[index];
                      final product = item['product'];
                      final quantity = item['quantity'] ?? 1;
                      final price = product.price ?? 0;
                      final imageUrl = product.imagePath.startsWith('http')
                          ? product.imagePath
                          : 'http://10.21.30.85:8000${product.imagePath}';
                      final size = item['size'] ?? '';

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        child: Row(
                          children: [
                            Image.network(
                              imageUrl,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '${price.toStringAsFixed(0)}đ',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                          border: Border.all(color: Colors.grey),
                                        ),
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          icon: Icon(Icons.remove, color: Colors.black),
                                          onPressed: () => _decreaseQuantity(index),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Text('$quantity'),
                                      ),
                                      Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.blue,
                                        ),
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          icon: Icon(Icons.add, color: Colors.white),
                                          onPressed: () => _increaseQuantity(index),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  'Size: $size',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () => _removeItem(index),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Tổng tiền: ${total.toStringAsFixed(0)}đ',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _navigateToCheckout,
                        child: Text('Thanh Toán'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}