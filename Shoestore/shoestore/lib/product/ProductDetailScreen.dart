import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  final Map<String, dynamic> product;

  ProductDetailScreen({required this.product, required String title, required String imagePath, required String price, required String badge, required String description, required String username});

  @override
  Widget build(BuildContext context) {
    // Extracting data with null safety and default values
    final String imagePath = product['imagePath'] ?? '';
    final String title = product['title'] ?? 'No Title';
    final String price = product['price'] ?? 'No Price';
    final String badge = product['badge'] ?? '';
    final String description = product['description'] ?? 'No Description';

    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFF8F9FA),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Navigate back when the back button is pressed
          },
        ),
        title: Text(
          'Giày Nam',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined, color: Colors.black),
            onPressed: () {
              // Add shopping cart action here
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: imagePath.isNotEmpty
                    ? Image.network(
                        imagePath,
                        width: 250,
                        height: 250,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: 250,
                        height: 250,
                        color: Colors.grey,
                        child: Icon(
                          Icons.image_not_supported,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (badge.isNotEmpty)
                      Text(
                        badge,
                        style: TextStyle(color: Colors.blue, fontSize: 12),
                      ),
                    Text(
                      title,
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      price,
                      style: TextStyle(fontSize: 20, color: Colors.red),
                    ),
                    SizedBox(height: 16),
                    Text(
                      description,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Trưng bày',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          DisplayImage(imageUrl: imagePath),
                          DisplayImage(imageUrl: imagePath),
                          DisplayImage(imageUrl: imagePath),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Kích cỡ',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizeOption(size: '38', isSelected: false),
                        SizeOption(size: '39', isSelected: false),
                        SizeOption(size: '40', isSelected: true),
                        SizeOption(size: '41', isSelected: false),
                        SizeOption(size: '42', isSelected: false),
                        SizeOption(size: '43', isSelected: false),
                      ],
                    ),
                    SizedBox(height: 16),
                    Center(
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Add purchase action here
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                            ),
                          ),
                          child: const Text(
                            'Mua',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DisplayImage extends StatelessWidget {
  final String imageUrl;

  DisplayImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          imageUrl,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 60,
              height: 60,
              color: Colors.grey,
              child: Icon(
                Icons.broken_image,
                color: Colors.white,
              ),
            );
          },
        ),
      ),
    );
  }
}

class SizeOption extends StatelessWidget {
  final String size;
  final bool isSelected;

  SizeOption({required this.size, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.grey[200],
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(
        size,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}