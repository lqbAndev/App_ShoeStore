import 'package:flutter/material.dart';

class NotificationSettingsScreen extends StatefulWidget {
  @override
  _NotificationSettingsScreenState createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool isNotificationEnabled = false;
  int selectedNotificationOption = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Color(0xFFF8F9FA),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Thiết lập thông báo',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Cho phép thông báo',
                  style: TextStyle(fontSize: 16),
                ),
                Switch(
                  value: isNotificationEnabled,
                  onChanged: (bool value) {
                    setState(() {
                      isNotificationEnabled = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'PHÁT THÔNG BÁO',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.notifications, color: Colors.blue),
              title: Text('Phát ngay'),
              subtitle: Text('Phát ngay lập tức'),
              trailing: selectedNotificationOption == 0
                  ? Icon(Icons.check, color: Colors.blue)
                  : null,
              onTap: () {
                setState(() {
                  selectedNotificationOption = 0;
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_today, color: Colors.blue),
              title: Text('Tóm tắt theo lịch trình'),
              subtitle: Text('Phát lúc 10:00 và 18:00'),
              trailing: selectedNotificationOption == 1
                  ? Icon(Icons.check, color: Colors.blue)
                  : null,
              onTap: () {
                setState(() {
                  selectedNotificationOption = 1;
                });
              },
            ),
            SizedBox(height: 10),
            Text(
              'Các thông báo được phát ngay lập tức.',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
