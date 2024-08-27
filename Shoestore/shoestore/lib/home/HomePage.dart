// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:shoestore/home/Cart.dart';
// import 'package:shoestore/home/NotificationScreen.dart';
// import 'package:shoestore/home/Favorite.dart';
// import 'package:shoestore/product/ProductDetailScreen.dart';
// import 'package:shoestore/profile/SileMenu.dart';
// import 'package:shoestore/home/BannerSlider.dart';
// import 'package:shoestore/home/BrandIcon.dart';
// import 'package:shoestore/home/ProductCard.dart';
// import 'package:shoestore/home/SearchScreen.dart';

// class Home extends StatelessWidget {
//   final String username;

//   Home({required this.username});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Shoe Store',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: HomeScreen(username: username),
//     );
//   }
// }

// class HomeScreen extends StatefulWidget {
//   final String username;

//   HomeScreen({required this.username});

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 0;
//   String selectedBrand = 'Nike';

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//     if (index == 1) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => FavoriteScreen()),
//       );
//     }
//     if (index == 2) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => NotificationScreen()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFF8F9FA),
//       appBar: AppBar(
//         backgroundColor: Color(0xFFF8F9FA),
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.menu, color: Colors.black),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => ProfileScreen(username: widget.username)),
//             );
//           },
//         ),
//         title: Stack(
//           children: [
//             Align(
//               alignment: Alignment.center,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text('Vị trí cửa hàng', style: TextStyle(color: Colors.grey, fontSize: 12)),
//                   Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(Icons.location_on, color: Colors.red, size: 14),
//                       SizedBox(width: 4),
//                       Text('Quận 10, TP HCM', style: TextStyle(color: Colors.black, fontSize: 14)),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.shopping_bag, color: Colors.black),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => CartScreen()),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => SearchScreen()),
//                 );
//               },
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Tìm kiếm giày',
//                   prefixIcon: Icon(Icons.search),
//                   filled: true,
//                   fillColor: const Color.fromARGB(255, 255, 255, 255),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//                 enabled: false,
//               ),
//             ),
//             SizedBox(height: 20),
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children: [
//                   BrandIcon(
//                     imagePath: 'images/icon_nike.png',
//                     brandName: 'Nike',
//                     isSelected: selectedBrand == 'Nike',
//                     onTap: () {
//                       setState(() {
//                         selectedBrand = 'Nike';
//                       });
//                     },
//                   ),
//                   BrandIcon(
//                     imagePath: 'images/puma.png',
//                     brandName: 'Puma',
//                     isSelected: selectedBrand == 'Puma',
//                     onTap: () {
//                       setState(() {
//                         selectedBrand = 'Puma';
//                       });
//                     },
//                   ),
//                   BrandIcon(
//                     imagePath: 'images/adidas.jpg',
//                     brandName: 'Adidas',
//                     isSelected: selectedBrand == 'Adidas',
//                     onTap: () {
//                       setState(() {
//                         selectedBrand = 'Adidas';
//                       });
//                     },
//                   ),
//                   BrandIcon(
//                     imagePath: 'images/converse.png',
//                     brandName: 'Converse',
//                     isSelected: selectedBrand == 'Converse',
//                     onTap: () {
//                       setState(() {
//                         selectedBrand = 'Converse';
//                       });
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 20),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     BannerSlider(), // Place BannerSlider here
//                     SizedBox(height: 10),
//                     if (selectedBrand == 'Nike') ...[
//                       Text(
//                         'Các sản phẩm Nike',
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(height: 10),                    
//                     ],
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {},
//         child: Icon(
//           Icons.shopping_bag,
//           color: Colors.white,
//         ),
//         backgroundColor: Colors.blue,
//         elevation: 2.0,
//         shape: CircleBorder(),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       bottomNavigationBar: BottomAppBar(
//         shape: CircularNotchedRectangle(),
//         notchMargin: 8.0,
//         color: Colors.white,
//         child: Container(
//           height: 60.0,
//           padding: EdgeInsets.symmetric(horizontal: 10.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Row(
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.home_outlined, color: _selectedIndex == 0 ? Colors.red : Colors.grey),
//                     onPressed: () => _onItemTapped(0),
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.favorite_border, color: _selectedIndex == 1 ? Colors.red : Colors.grey),
//                     onPressed: () => _onItemTapped(1),
//                   ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.notifications_none, color: _selectedIndex == 2 ? Colors.red : Colors.grey),
//                     onPressed: () => _onItemTapped(2),
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.person_outline, color: _selectedIndex == 3 ? Colors.red : Colors.grey),
//                     onPressed: () => _onItemTapped(3),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
