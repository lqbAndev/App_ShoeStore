import 'package:flutter/material.dart';
class SearchScreen extends StatelessWidget {
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
        title: Text('Tìm kiếm', style: TextStyle(color: Colors.black)),
        backgroundColor: Color(0xFFF8F9FA),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text('Hủy bỏ', style: TextStyle(color: Colors.blue)),
          ),
        ],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Mục tìm kiếm gần đây',
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Color.fromARGB(255, 255, 255, 255),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Giày',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ListTile(
                leading: Icon(Icons.access_time),
                title: Text('Nike Air Max'),
                onTap: () {
                  // Xử lý khi nhấn vào
                },
              ),
              ListTile(
                leading: Icon(Icons.access_time),
                title: Text('Nike Jordan'),
                onTap: () {
                  // Xử lý khi nhấn vào
                },
              ),
              ListTile(
                leading: Icon(Icons.access_time),
                title: Text('Nike Air Force'),
                onTap: () {
                  // Xử lý khi nhấn vào
                },
              ),
              ListTile(
                leading: Icon(Icons.access_time),
                title: Text('Nike Club Max'),
                onTap: () {
                  // Xử lý khi nhấn vào
                },
              ),
              ListTile(
                leading: Icon(Icons.access_time),
                title: Text('Snakers Nike'),
                onTap: () {
                  // Xử lý khi nhấn vào
                },
              ),
              ListTile(
                leading: Icon(Icons.access_time),
                title: Text('Adidas UltraBoost'),
                onTap: () {
                  // Xử lý khi nhấn vào
                },
              ),
              ListTile(
                leading: Icon(Icons.access_time),
                title: Text('Converse Chuck Taylor'),
                onTap: () {
                  // Xử lý khi nhấn vào
                },
              ),
              ListTile(
                leading: Icon(Icons.access_time),
                title: Text('Puma Suede Classic'),
                onTap: () {
                  // Xử lý khi nhấn vào
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}