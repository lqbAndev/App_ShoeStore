import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shoestore/home/HomePage.dart';
import 'package:shoestore/test/ProductListPage.dart';
import 'register.dart'; // Import trang RegisterScreen

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    final response = await http.post(
      Uri.parse('http://10.21.30.85:8000/api/login/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final String token = responseData['token'];
      final String userId = responseData['user_id'].toString(); // Chuyển đổi int sang String
      final String userName = responseData['username'];

      // Lưu token và user info nếu cần thiết, sau đó chuyển hướng đến trang home
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProductListPage(username: userName, token: '', cart: [], favoriteProducts: [], products: [], onItemTapped: (int value) {  },)),
      );
    } else {
      // Hiển thị thông báo lỗi
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Login failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView( // Đảm bảo giao diện không bị cắt trên màn hình nhỏ
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                ClipRRect(
                  borderRadius: BorderRadius.circular(50.0), // Bo tròn hình ảnh
                  child: Image.asset(
                    'images/bcd.png', // Đường dẫn tới hình ảnh
                    height: 100, // Chiều cao của hình ảnh
                  ),
                ),
                SizedBox(height: 30),
                // Welcome Text
                Text(
                  'Xin Chào',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
                // Username TextField
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Địa chỉ Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Password TextField
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Mật Khẩu',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    suffixIcon: Icon(Icons.visibility_off),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 10),
                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Add your forgot password functionality here
                    },
                    child: Text('Khôi phục mật khẩu',style: TextStyle(color: Colors.blue), ),
                  ),
                ),
                SizedBox(height: 20),
                // Login Button
                ElevatedButton(
                  onPressed: _login,
                  child: Text('Đăng nhập',
                  style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 140, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Google Sign-In Button
                OutlinedButton.icon(
                  onPressed: () {
                    // Add your Google sign-in functionality here
                  },
                  icon: ClipRRect(
                    borderRadius: BorderRadius.circular(17.0), // Bo tròn biểu tượng Google
                    child: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/4/4a/Logo_2013_Google.png', // Replace with your Google logo URL
                      height: 34,
                      width: 34,
                    ),
                  ),
                  label: Text('Đăng nhập với Google', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 85, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Register Text
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: Text(
                    'Bạn Chưa Có Tài Khoản? Đăng Ký Ngay!',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
