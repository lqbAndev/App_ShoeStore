import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  CustomBottomNavigationBar({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 8.0,
      color: Colors.white,
      child: Container(
        height: 60.0,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.home_outlined, color: selectedIndex == 0 ? Colors.red : Colors.grey),
                  onPressed: () => onItemTapped(0),
                ),
                IconButton(
                  icon: Icon(Icons.favorite_border, color: selectedIndex == 1 ? Colors.red : Colors.grey),
                  onPressed: () => onItemTapped(1),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.notifications_none, color: selectedIndex == 2 ? Colors.red : Colors.grey),
                  onPressed: () => onItemTapped(2),
                ),
                IconButton(
                  icon: Icon(Icons.local_shipping, color: selectedIndex == 3 ? Colors.red : Colors.grey), // Sử dụng biểu tượng local_shipping
                  onPressed: () => onItemTapped(3),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
