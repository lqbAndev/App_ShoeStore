import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Giỏ hàng của tôi', style: TextStyle(color: Colors.black)),
        backgroundColor: Color(0xFFF8F9FA),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                CartItem(
                  image: 'images/shoes_1.png',
                  name: 'Nike Club Max',
                  price: '1.626.451đ',
                  quantity: 1,
                ),
                CartItem(
                  image: 'images/shoes_1.png',
                  name: 'Nike Air Max 200',
                  price: '1.626.451đ',
                  quantity: 1,
                ),
                CartItem(
                  image: 'images/shoes_1.png',
                  name: 'Nike Air Max',
                  price: '1.626.451đ',
                  quantity: 1,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SummaryRow(label: 'Tạm tính', value: '4.879.353đ'),
                SummaryRow(label: 'Phí vận chuyển', value: '100.000đ'),
                Divider(),
                SummaryRow(label: 'Tổng chi phí', value: '4.979.353đ', isTotal: true),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Hành động khi nhấn vào nút "Thanh toán"
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.0), backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0),
                    ), // Màu nền của nút
                  ),
                  child: Center(
                    child: Text(
                      'Thanh toán', 
                      style: TextStyle(
                        fontSize: 16.0, 
                        color: Colors.white, // Set text color to white
                      ), 
                    ),
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

class CartItem extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final int quantity;

  const CartItem({
    Key? key,
    required this.image,
    required this.name,
    required this.price,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Image.asset(image, width: 60, height: 60),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                Text(price, style: TextStyle(fontSize: 14.0, color: Colors.grey)),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  // Giảm số lượng
                },
              ),
              Text('$quantity'),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  // Tăng số lượng
                },
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.delete_outline, color: Colors.grey),
            onPressed: () {
              // Xóa sản phẩm
            },
          ),
        ],
      ),
    );
  }
}

class SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;

  const SummaryRow({
    Key? key,
    required this.label,
    required this.value,
    this.isTotal = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
             Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16.0 : 14.0,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.black : Colors.grey,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 16.0 : 14.0,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.black : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}