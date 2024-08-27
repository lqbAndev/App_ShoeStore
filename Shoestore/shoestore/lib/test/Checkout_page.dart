import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shoestore/test/paypal.dart'; // Import PayPal page

class CheckoutPage extends StatefulWidget {
  final double total;
  final List<Map<String, dynamic>> cart;

  CheckoutPage({required this.total, required this.cart});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  String? _address;
  String? _paymentMethod = 'cash';
  String? _selectedCountry;
  String? _selectedCity;

  // Sample list of countries and cities
  final List<String> _countries = ['VietNam','USA', 'Canada', 'UK', 'Australia', 'France', 'Germany', 'Japan', 'China', 'India', 'Brazil'];
  final Map<String, List<String>> _cities = {
    'USA': ['New York', 'Los Angeles', 'Chicago'],
    'Canada': ['Toronto', 'Vancouver', 'Montreal'],
    'UK': ['London', 'Manchester', 'Birmingham'],
    'Australia': ['Sydney', 'Melbourne', 'Brisbane'],
    'France': ['Paris', 'Lyon', 'Marseille'],
    'Germany': ['Berlin', 'Munich', 'Frankfurt'],
    'Japan': ['Tokyo', 'Osaka', 'Kyoto'],
    'China': ['Beijing', 'Shanghai', 'Guangzhou'],
    'India': ['Delhi', 'Mumbai', 'Bangalore'],
    'Brazil': ['São Paulo', 'Rio de Janeiro', 'Brasília'],
    'VietNam': ['HoChiMinh','HaNoi', 'DaNang'],
  };

  void _submitOrder() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_paymentMethod == 'paypal') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PayPalPage(total: widget.total, cart: [],),
          ),
        );
      } else {
        // Handle cash payment
        // Call Django API to save the order
        _saveOrderToDjango();
      }
    }
  }

  void _saveOrderToDjango() async {
    final orderData = {
      'address': _address,
      'payment_method': _paymentMethod,
      'total': widget.total,
      'items': widget.cart.map((item) {
        return {
          'product_id': item['product'].id,
          'quantity': item['quantity'],
          'size': item['size'],
          'color': item['color'],
        };
      }).toList(),
    };

    final response = await http.post(
      Uri.parse('http://10.21.30.85:8000/api/create-order/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(orderData),
    );

    if (response.statusCode == 201) {
      // Show success dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Thành công'),
            content: Text('Đặt hàng thành công!'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil('/productListPage', (Route<dynamic> route) => false);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đặt hàng thất bại!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thanh Toán'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Địa chỉ'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập địa chỉ';
                  }
                  return null;
                },
                onSaved: (value) {
                  _address = value;
                },
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Quốc gia'),
                value: _selectedCountry,
                items: _countries.map((country) {
                  return DropdownMenuItem<String>(
                    value: country,
                    child: Text(country),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCountry = value;
                    _selectedCity = null; // Reset city when country changes
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Vui lòng chọn quốc gia';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Thành phố'),
                value: _selectedCity,
                items: _selectedCountry == null
                    ? []
                    : _cities[_selectedCountry]!.map((city) {
                        return DropdownMenuItem<String>(
                          value: city,
                          child: Text(city),
                        );
                      }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCity = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Vui lòng chọn thành phố';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              Text('Chọn phương thức thanh toán:'),
              RadioListTile<String>(
                title: Text('Tiền mặt'),
                value: 'cash',
                groupValue: _paymentMethod,
                onChanged: (value) {
                  setState(() {
                    _paymentMethod = value;
                  });
                },
              ),
              RadioListTile<String>(
                title: Text('PayPal'),
                value: 'paypal',
                groupValue: _paymentMethod,
                onChanged: (value) {
                  setState(() {
                    _paymentMethod = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitOrder,
                child: Text('Đặt hàng'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}