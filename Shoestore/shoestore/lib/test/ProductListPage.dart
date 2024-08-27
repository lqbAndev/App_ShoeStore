import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shoestore/home/BrandIcon.dart';
import 'package:shoestore/home/Favorite.dart';
import 'package:shoestore/home/NotificationScreen.dart';
import 'package:shoestore/profile/SileMenu.dart';
import 'package:shoestore/test/CartPage.dart';
import 'package:shoestore/test/NavigationBar.dart';
import 'package:shoestore/test/ProductDetail_Page.dart';
import 'package:shoestore/test/api_service.dart';
import 'package:shoestore/test/orderpage.dart';

class ProductListPage extends StatefulWidget {
  final String username;
  final String token;
  final List<Map<String, dynamic>> cart;
  final List<Product> favoriteProducts;
  final List<Product> products;
  final ValueChanged<int> onItemTapped;

  ProductListPage({
    required this.username,
    required this.token,
    required this.cart,
    required this.favoriteProducts,
    required this.products,
    required this.onItemTapped,
  });

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late Future<List<Product>> _futureProducts;
  List<Map<String, dynamic>> cart = [];
  List<Product> favoriteProducts = [];
  String selectedBrand = 'All';
  String searchText = '';
  String selectedSize = 'All';
  String selectedColor = 'All';
  RangeValues priceRange = RangeValues(0, 10000);
  double maxPrice = 10000;
  int _selectedIndex = 0;
  late PageController _pageController;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    cart = widget.cart;
    favoriteProducts = widget.favoriteProducts;
    _futureProducts = _fetchProducts();
    _pageController = PageController();
    _startAutoPageChange();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoPageChange() {
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_pageController.hasClients) {
        int nextPage = (_pageController.page?.toInt() ?? 0) + 1;
        _pageController.animateToPage(
          nextPage % 3, // Giả sử có 3 banner, bạn có thể thay đổi giá trị này nếu số lượng khác
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }
  

 
  Future<List<Product>> _fetchProducts() async {
    final response = await http.get(
      Uri.parse('http://10.21.30.85:8000/api/products/'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token ${widget.token}',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> productList = jsonDecode(utf8.decode(response.bodyBytes));
      List<Product> products = productList.map((json) => Product.fromJson(json)).toList();

      maxPrice = products.map((product) => product.price).reduce((a, b) => a > b ? a : b);
      priceRange = RangeValues(0, maxPrice);

      products = _filterProducts(products);

      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }

  List<Product> _filterProducts(List<Product> products) {
    if (selectedBrand != 'All') {
      products = products.where((product) => product.brand?.toLowerCase() == selectedBrand.toLowerCase()).toList();
    }
    if (searchText.isNotEmpty) {
      products = products.where((product) => product.title.toLowerCase().contains(searchText.toLowerCase())).toList();
    }
    if (selectedSize != 'All') {
      products = products.where((product) => product.sizes.contains(selectedSize)).toList();
    }
    if (selectedColor != 'All') {
      products = products.where((product) => product.colors.contains(selectedColor)).toList();
    }
    products = products.where((product) => product.price >= priceRange.start && product.price <= priceRange.end).toList();

    return products;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

      if (index == 0) {
      // Điều hướng đến trang Home
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FavoritePage(
            favoriteProducts: widget.favoriteProducts,
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
            onItemTapped: (int value) {
              // Xử lý các sự kiện điều hướng cho NotificationPage nếu cần
            },
          ),
        ),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderPage(),
        ),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
}
  }

  void _addToFavorites(Product product) {
    setState(() {
      favoriteProducts.add(product);
    });
  }

  void _addToCart(Map<String, dynamic> cartItem) {
    setState(() {
      cart.add(cartItem);
    });
  }

  void _navigateToCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartPage(cart: cart),
      ),
    );
  }

  void _onBrandSelected(String brand) {
    setState(() {
      selectedBrand = brand;
      _futureProducts = _fetchProducts();
    });
  }

  void _onSearchTextChanged(String text) {
    setState(() {
      searchText = text;
      _futureProducts = _fetchProducts();
    });
  }

  void _applyAdvancedSearch() {
    setState(() {
      _futureProducts = _fetchProducts();
    });
  }

  void _showAdvancedSearch() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tìm kiếm nâng cao', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  Text('Size'),
                  DropdownButton<String>(
                    value: selectedSize,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedSize = newValue!;
                      });
                    },
                    items: <String>['All', '40', '41', '42', '43', '44', '45']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  Text('Màu'),
                  DropdownButton<String>(
                    value: selectedColor,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedColor = newValue!;
                      });
                    },
                    items: <String>['All', 'ff0000', '00ff00', '0000ff']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  Text('Khoảng giá'),
                  RangeSlider(
                    values: priceRange,
                    min: 0,
                    max: maxPrice,
                    divisions: maxPrice.toInt(),
                    labels: RangeLabels('${priceRange.start}', '${priceRange.end}'),
                    onChanged: (RangeValues values) {
                      setState(() {
                        priceRange = values;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _applyAdvancedSearch();
                    },
                    child: Text('Áp dụng'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Products'),
      leading: IconButton(
        icon: Icon(Icons.settings),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileScreen(username: '',), // Chuyển hướng đến SettingsPage
            ),
          );
        },
      ),
      actions: [
  Stack(
    children: [
      IconButton(
        icon: Icon(Icons.shopping_bag),
        onPressed: _navigateToCart,
      ),
      if (cart.isNotEmpty) // Kiểm tra nếu có sản phẩm trong giỏ hàng
        Positioned(
          right: 0,
          top: 0,
          child: Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(12),
            ),
            constraints: BoxConstraints(
              maxWidth: 24,
              maxHeight: 24,
            ),
            child: Center(
              child: Text(
                '${cart.length}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
    ],
  ),
],
      automaticallyImplyLeading: false, // Loại bỏ nút quay lại
    ),
    body: CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Tìm kiếm sản phẩm...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0), // Độ bo tròn của khung
                        borderSide: BorderSide.none, // Không có viền
                      ),
                      filled: true, // Để có nền trắng hoặc màu sắc khác
                      fillColor: Colors.white, // Màu nền của khung
                      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20), // Padding để biểu tượng và văn bản không chạm viền
                    ),
                    onChanged: _onSearchTextChanged,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: _showAdvancedSearch,
                ),
              ],
            ),
          ),
        ),
        
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0), // Thay đổi khoảng cách bên trái và bên phải của banner
            child: SizedBox(
              height: 200, // Chiều cao của PageView
              child: PageView(
                controller: _pageController,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0), // Bo tròn các góc với bán kính 12.0
                    child: Image.asset('images/banner_1.jpg', fit: BoxFit.cover),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0), // Bo tròn các góc với bán kính 12.0
                    child: Image.asset('images/banner_2.jpg', fit: BoxFit.cover),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0), // Bo tròn các góc với bán kính 12.0
                    child: Image.asset('images/banner_3.jpg', fit: BoxFit.cover),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: 20),
        ),
        SliverToBoxAdapter(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                BrandIcon(
                  imagePath: 'images/all-logo.png',
                  brandName: 'All',
                  isSelected: selectedBrand == 'All',
                  onTap: () {
                    _onBrandSelected('All');
                  },
                ),
                BrandIcon(
                  imagePath: 'images/icon_nike.png',
                  brandName: 'Nike',
                  isSelected: selectedBrand == 'Nike',
                  onTap: () {
                    _onBrandSelected('Nike');
                  },
                ),
                BrandIcon(
                  imagePath: 'images/puma.png',
                  brandName: 'Puma',
                  isSelected: selectedBrand == 'Puma',
                  onTap: () {
                    _onBrandSelected('Puma');
                  },
                ),
                BrandIcon(
                  imagePath: 'images/adidas.jpg',
                  brandName: 'Adidas',
                  isSelected: selectedBrand == 'Adidas',
                  onTap: () {
                    _onBrandSelected('Adidas');
                  },
                ),
                BrandIcon(
                  imagePath: 'images/converse.png',
                  brandName: 'Converse',
                  isSelected: selectedBrand == 'Converse',
                  onTap: () {
                    _onBrandSelected('Converse');
                  },
                ),
              ],
            ),
          ),
        ),
        SliverFillRemaining(
          child: FutureBuilder<List<Product>>(
            future: _futureProducts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
                return Center(child: Text('No products found'));
              } else {
                List<Product> products = snapshot.data!;
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 sản phẩm mỗi hàng
                    crossAxisSpacing: 8.0, // Khoảng cách ngang giữa các sản phẩm
                    mainAxisSpacing: 8.0, // Khoảng cách dọc giữa các sản phẩm
                    childAspectRatio: 0.75, // Tỷ lệ của từng sản phẩm (có thể điều chỉnh để phù hợp với thiết kế)
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
  Product product = products[index];
  String imageUrl = product.imagePath.startsWith('http')
      ? product.imagePath
      : 'http://10.21.30.85:8000${product.imagePath}';
  return GestureDetector(
    onTap: () async {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailPage(
            product: product,
            cart: cart,
            token: widget.token,
            favoriteProducts: favoriteProducts,
            notificationProducts: [], onAddToCart: (Map<String, dynamic> cartItem) {  }, onAddToFavorites: (Product product) {  },
          ),
        ),
      );
      if (result != null) {
        _addToCart(result);
      }
    },
    child: Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
            height: 140,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.title,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
                fontSize: 16, // Kích thước chữ tiêu đề
              ),
            ),
          ),
          Padding(
  padding: const EdgeInsets.symmetric(horizontal: 8.0),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (product.oldPrice != null)
        Text(
          '${product.oldPrice} VND',
          style: TextStyle(
            color: const Color.fromARGB(255, 255, 0, 0),
            fontSize: 14,
            decoration: TextDecoration.lineThrough,
          ),
        ),
      Text(
        '${product.price} VND',
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),
      ),
    ],
  ),
),
        ],
      ),
    ),
  );
}
                );
              }
            },
          ),
        ),
      ],
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: _navigateToCart,
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
      selectedIndex: _selectedIndex,
      onItemTapped: _onItemTapped,
    ),
  );
}

}

class Product {
  final int id;
  final String title;
  final String imagePath;
  final double price;
  final double? oldPrice;  // Thêm trường oldPrice
  final String? badge;
  final String description;
  final List<String> colors;
  final List<String> sizes;
  final String? brand;

  Product({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.price,
    this.oldPrice,
    this.badge,
    required this.description,
    required this.colors,
    required this.sizes,
    this.brand,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    double price;
    if (json['price'] is String) {
      price = double.parse(json['price']);
    } else {
      price = json['price'].toDouble();
    }

    double? oldPrice;
    if (json['old_price'] != null) {
      oldPrice = json['old_price'] is String ? double.parse(json['old_price']) : json['old_price'].toDouble();
    }

    return Product(
      id: json['id'],
      title: json['title'],
      imagePath: json['imagePath'].startsWith('http') ? json['imagePath'] : '/${json['imagePath']}',
      price: price,
      oldPrice: oldPrice,
      badge: json['badge'],
      description: json['description'],
      colors: List<String>.from(json['colors']),
      sizes: List<String>.from(json['sizes']),
      brand: json['brand'],
    );
  }
}
