
import 'package:d_mart/Widgets/Products_Cart.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
        backgroundColor: HexColor('#d91f2a'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search,color: Colors.white,)),
        ],
      ),
      body: ProductCart(),
    );
  }
}
