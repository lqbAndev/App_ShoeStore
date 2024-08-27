import 'package:flutter/material.dart';
import 'package:shoestore/home/Favorite.dart';
import 'package:shoestore/home/NotificationScreen.dart';
import 'package:shoestore/test/CartPage.dart';
import 'package:shoestore/test/NavigationBar.dart';
import 'package:shoestore/test/ProductListPage.dart';


class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  int selectedIndex = 3; // Đặt chỉ số chọn phù hợp với OrderPage

  void _navigateToCart(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartPage(cart: []), // Thay thế bằng danh sách giỏ hàng thực tế
      ),
    );
  }

  void _onItemTapped(int index) {
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
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FavoritePage(
            favoriteProducts: [], // Thay thế bằng danh sách sản phẩm yêu thích thực tế
            selectedIndex: index,
            onItemTapped: _onItemTapped,
          ),
        ),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NotificationPage(
            selectedIndex: index,
            onItemTapped: _onItemTapped,
          ),
        ),
      );
    } else if (index == 3) {
      // Đã ở trang OrderPage, không cần làm gì
    } else {
      setState(() {
        selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đơn hàng của tôi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Thay thế bằng danh sách đơn hàng thực tế
            OrderItem(
              orderNumber: '001',
              orderDate: '2024-07-24',
              status: 'Đang xử lý',
            ),
            OrderItem(
              orderNumber: '002',
              orderDate: '2024-07-22',
              status: 'Đã giao',
            ),
            // Thêm các mục đơn hàng khác ở đây
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
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  final String orderNumber;
  final String orderDate;
  final String status;

  OrderItem({
    required this.orderNumber,
    required this.orderDate,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text('Đơn hàng #$orderNumber'),
        subtitle: Text('Ngày: $orderDate'),
        trailing: Text(status, style: TextStyle(color: status == 'Đã giao' ? Colors.green : Colors.red)),
        onTap: () {
          // Thực hiện hành động khi nhấp vào đơn hàng
        },
      ),
    );
  }
}
