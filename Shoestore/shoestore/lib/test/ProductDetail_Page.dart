import 'package:flutter/material.dart';
import 'package:shoestore/test/ProductListPage.dart';
import 'package:intl/intl.dart';
import 'package:shoestore/test/CartPage.dart';
import 'package:shoestore/home/Favorite.dart'; // Đảm bảo import trang yêu thích

class ProductDetailPage extends StatefulWidget {
  final Product product;
  final List<Map<String, dynamic>> cart;
  final List<Product> favoriteProducts;

  ProductDetailPage({
    required this.product,
    required this.cart,
    required this.favoriteProducts,
    required String token,
    required List notificationProducts,
    required void Function(Map<String, dynamic> cartItem) onAddToCart,
    required void Function(Product product) onAddToFavorites,
  });

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  String? selectedSize;
  String? selectedColor;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.favoriteProducts.contains(widget.product);
  }

  void _showFavoriteDialog(String action) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(action == 'add' ? 'Thêm vào danh sách yêu thích' : 'Xóa khỏi danh sách yêu thích'),
          content: Text(action == 'add'
              ? 'Bạn có chắc chắn muốn thêm sản phẩm này vào danh sách yêu thích?'
              : 'Bạn có chắc chắn muốn xóa sản phẩm này khỏi danh sách yêu thích?'),
          actions: [
            TextButton(
              child: Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                setState(() {
                  if (action == 'add') {
                    widget.favoriteProducts.add(widget.product);
                    Navigator.of(context).pop();
                    _showNotificationDialog('Đã thêm vào danh sách yêu thích');
                  } else {
                    widget.favoriteProducts.remove(widget.product);
                    Navigator.of(context).pop();
                    _showNotificationDialog('Đã xóa khỏi danh sách yêu thích');
                  }
                  isFavorite = !isFavorite;
                });
              },
            ),
          ],
        );
      },
    );
  }

  void _showNotificationDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thông báo'),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String imageUrl = widget.product.imagePath.startsWith('http')
        ? widget.product.imagePath
        : 'http://10.21.30.85:8000${widget.product.imagePath}';
    
    // Đảm bảo product price không bị null
    final double price = widget.product.price;
    final double? oldPrice = widget.product.oldPrice; // Thêm oldPrice
    final NumberFormat currencyFormat = NumberFormat.currency(
        locale: 'vi_VN', symbol: 'VND', decimalDigits: 0);
    final String formattedPrice = currencyFormat.format(price);
    final String formattedOldPrice = oldPrice != null
        ? currencyFormat.format(oldPrice)
        : ''; // Định dạng oldPrice

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: () {
              _showFavoriteDialog(isFavorite ? 'remove' : 'add');
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_bag),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(cart: widget.cart),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: Image.network(imageUrl),
            ),
            SizedBox(height: 16.0),
            if (widget.product.badge != null) ...[
              Text(
                widget.product.badge!,
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
              SizedBox(height: 16.0),
            ],
            Text(
              widget.product.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            if (oldPrice != null) ...[
              Text(
                formattedOldPrice,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              SizedBox(height: 8.0),
            ],
            Text(
              formattedPrice,
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
            Text(
              widget.product.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16.0),
            Text(
              'Available Colors:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              children: widget.product.colors.map((color) {
                bool isSelected = selectedColor == color;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedColor = color;
                    });
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Color(int.parse('0xff$color')),
                      shape: BoxShape.circle,
                      border: isSelected
                          ? Border.all(color: Colors.black, width: 2.0)
                          : null,
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            Text(
              'Available Sizes:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              children: widget.product.sizes.map((size) {
                bool isSelected = selectedSize == size;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedSize = size;
                    });
                  },
                  child: Chip(
                    label: Text(size),
                    backgroundColor: isSelected ? Colors.blue : Colors.white,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                onPressed: selectedSize != null && selectedColor != null
                    ? () {
                        // Thêm sản phẩm vào giỏ hàng
                        widget.cart.add({
                          'product': widget.product,
                          'quantity': 1,
                          'size': selectedSize,
                          'color': selectedColor,
                        });

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CartPage(cart: widget.cart),
                          ),
                        );
                      }
                    : null,
                child: Text('Mua'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
