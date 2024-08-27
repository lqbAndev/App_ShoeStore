import 'package:flutter/material.dart';

class Profile_Screen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<Profile_Screen> {
  final TextEditingController nameController = TextEditingController(text: 'Nguyễn Văn An');
  final TextEditingController genderController = TextEditingController(text: 'Nam');
  final TextEditingController birthdateController = TextEditingController(text: '01/01/2000');
  final TextEditingController emailController = TextEditingController(text: 'nguyenvanan@gmail.com');
  final TextEditingController addressController = TextEditingController(text: '100 Sư Vạn Hạnh, Quận 10, TP.HCM');
  
  @override
  void dispose() {
    nameController.dispose();
    genderController.dispose();
    birthdateController.dispose();
    emailController.dispose();
    addressController.dispose();
    super.dispose();
  }

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
        title: Text('Trang cá nhân', style: TextStyle(color: Colors.black)),
        backgroundColor: Color(0xFFF8F9FA),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage('images/avata.jpg'), // Thay thế bằng đường dẫn ảnh của bạn
              ),
              SizedBox(height: 16.0),
              Text(
                'Nguyễn Văn An',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 32.0),
              ProfileField(
                label: 'Họ và Tên',
                controller: nameController,
              ),
              ProfileField(
                label: 'Giới tính',
                controller: genderController,
                isDropdown: true,
              ),
              ProfileField(
                label: 'Ngày sinh',
                controller: birthdateController,
              ),
              ProfileField(
                label: 'Email',
                controller: emailController,
              ),
              ProfileField(
                label: 'Địa chỉ',
                controller: addressController,
              ),
              SizedBox(height: 32.0), // Khoảng cách giữa các trường thông tin và nút lưu
              ElevatedButton(
                onPressed: () {
                  _showSuccessDialog();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Màu xanh cho nút
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 150.0),
                ),
                child: Text(
                  'Lưu',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: const Color.fromARGB(255, 255, 255, 255), // Set text color to white
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: true, // Cho phép người dùng đóng hộp thoại bằng cách nhấn ra ngoài
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thông báo'),
          content: Text('Lưu thành công!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng hộp thoại
              },
              child: Text('Đóng'),
            ),
          ],
        );
      },
    );
  }
}

class ProfileField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isDropdown;

  const ProfileField({
    Key? key,
    required this.label,
    required this.controller,
    this.isDropdown = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16.0, color: Colors.grey),
          ),
          SizedBox(height: 8.0),
          isDropdown
              ? DropdownButtonFormField<String>(
                  value: controller.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  items: ['Nam', 'Nữ'].map((String gender) {
                    return DropdownMenuItem<String>(
                      value: gender,
                      child: Text(gender),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    controller.text = newValue!;
                  },
                )
              : TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  ),
                ),
        ],
      ),
    );
  }
}
