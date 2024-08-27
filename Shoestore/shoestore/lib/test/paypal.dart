import 'package:flutter/material.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
import 'package:shoestore/test/ProductListPage.dart';


class PayPalPage extends StatefulWidget {
  final double total;
  final List<Map<String, dynamic>> cart;

  const PayPalPage({
    super.key,
    required this.total,
    required this.cart,
  });

  @override
  State<PayPalPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<PayPalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "PayPal Checkout",
          style: TextStyle(fontSize: 20),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => ProductListPage(username: '', token: '', cart: [], favoriteProducts: [], products: const [], onItemTapped: (int value) {  },),
            ));
          },
        ),
      ),
      body: Center(
        child: TextButton(
          onPressed: () async {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => PaypalCheckout(
                sandboxMode: true,
                clientId: "AbhWPtPpCfQ594THKHWkENiGxauiRRj57TnD_nepNnPT_f8_uZQ5uo6li623PbhkRoRrfM4y-C_UG9tm",
                secretKey: "EAUrkuffOM85nLWQw2URia5y75haGFuVtgm8sSy0xZ25Pc6jjl27SqI49CyGIvmPItDSYnhe9tsMMYCu",
                returnURL: "success.snippetcoder.com",
                cancelURL: "cancel.snippetcoder.com",
                transactions: [
                  {
                    "amount": {
                      "total": widget.total.toStringAsFixed(2),
                      "currency": "USD",
                      "details": {
                        "subtotal": widget.total.toStringAsFixed(2),
                        "shipping": '0',
                        "shipping_discount": 0
                      }
                    },
                    "description": "The payment transaction description.",
                    "item_list": {
                      "items": widget.cart.map((item) {
                        return {
                          "name": item['product'].title,
                          "quantity": item['quantity'].toString(),
                          "price": item['product'].price.toString(),
                          "currency": "USD"
                        };
                      }).toList(),
                    }
                  }
                ],
                note: "Contact us for any questions on your order.",
                onSuccess: (Map params) async {
                  print("onSuccess: $params");
                  Navigator.pop(context);
                },
                onError: (error) {
                  print("onError: $error");
                  Navigator.pop(context);
                },
                onCancel: () {
                  print('cancelled:');
                  Navigator.pop(context);
                },
              ),
            ));
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            shape: const BeveledRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(1),
              ),
            ),
          ),
          child: const Text('Checkout'),
        ),
      ),
    );
  }
}
