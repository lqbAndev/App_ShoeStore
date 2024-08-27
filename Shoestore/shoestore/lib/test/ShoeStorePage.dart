import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Thêm package url_launcher

class ShoeStorePage extends StatelessWidget {
  // Hàm để mở đường dẫn trong trình duyệt
  Future<void> _launchURL() async {
    const url = 'https://www.google.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Không thể mở $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA), // Thay đổi màu nền
      body: Container(
        width: double.infinity, // Chiếm toàn bộ chiều rộng màn hình
        height: double.infinity, // Chiếm toàn bộ chiều cao màn hình
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Căn giữa các phần tử theo chiều dọc
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              ),
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Column(
                children: [
                  Text(
                    'CHÀO MỪNG ĐẾN VỚI',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24, // Tăng kích thước chữ
                    ),
                  ),
                  SizedBox(height: 10),
                  Image.asset(
                    'images/aaaaa.png', // Đường dẫn tới hình ảnh logo
                    height: 50,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'SHOE STORE',
                    style: TextStyle(
                      color: Color(0xFF5EA1E3),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Text('Bắt đầu',),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 140, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            SizedBox(height: 30),
            TextButton(
              onPressed: _launchURL,
              child: Text(
                'Truy cập Google',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
