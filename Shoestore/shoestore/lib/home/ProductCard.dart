import 'package:flutter/material.dart';
import 'package:shoestore/product/Product.dart';
import 'package:shoestore/product/ProductDetailScreen.dart';

class ProductCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String price;
  final String badge;
  final String description; // Added description parameter

  ProductCard({
    required this.imagePath,
    required this.title,
    required this.price,
    required this.badge,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigate to the product detail screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(
              title: title,
              imagePath: imagePath,
              price: price,
              badge: badge,
              description: description, product: {}, username: '', // Pass the description to the detail screen
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (badge.isNotEmpty)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          badge,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    Spacer(),
                    Icon(Icons.add, color: Colors.blue),
                  ],
                ),
                SizedBox(height: 10),
                Center(
                  child: Image.network(imagePath, height: 100),
                ),
                SizedBox(height: 10),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 128, 128, 128),
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