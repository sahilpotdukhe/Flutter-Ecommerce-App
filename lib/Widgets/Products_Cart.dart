import 'package:flutter/material.dart';

class ProductCart extends StatefulWidget {
  @override
  _ProductCartState createState() => _ProductCartState();
}

class _ProductCartState extends State<ProductCart> {
  var cartlist = [
    {
      'name': 'Blazer', //name is the key and blazer is the value of  the key
      'picture': 'Assets/blazer1.jpg',
      'old_price': 200,
      'price': 160,
      'color': 'Black',
      'size': 'M',
      'qty': 2,
    },
    {
      'name': 'Dress',
      'picture': 'Assets/dress1.jpg',
      'old_price': 320,
      'price': 250,
      'color': 'Navy Blue',
      'size': 'M',
      'qty': 1,
    },
    {
      'name': 'Jeans',
      'picture': 'Assets/jeans.jpg',
      'old_price': 150,
      'price': 85,
      'color': 'Black',
      'size': 'XL',
      'qty': 3,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cartlist.length,
      itemBuilder: (BuildContext context, int index) {
        return SingleCartproduct(
          cartpro_name: cartlist[index]['name'],
          cartpro_picture: cartlist[index]['picture'],
          cartpro_oldprice: cartlist[index]['old_price'],
          cartpro_price: cartlist[index]['price'],
          cartpro_color: cartlist[index]['color'],
          cartpro_size: cartlist[index]['size'],
          cartpro_qty: cartlist[index]['qty'],
        );
      },
    );
  }
}

class SingleCartproduct extends StatelessWidget {
  final cartpro_name;
  final cartpro_picture;
  final cartpro_oldprice;
  final cartpro_price;
  final cartpro_color;
  final cartpro_size;
  final cartpro_qty;

  SingleCartproduct(
      {this.cartpro_name,
      this.cartpro_picture,
      this.cartpro_oldprice,
      this.cartpro_price,
      this.cartpro_color,
      this.cartpro_size,
      this.cartpro_qty});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Card(
      child: Container(
        height: height * 0.2,
        child: Row(
          children: [
            Image.asset(
              cartpro_picture,
              width: width * 0.4,
              fit: BoxFit.fill,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(2, 8, 0, 0),
                  child: Text(
                    cartpro_name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Special Price',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.green[900],
                          fontWeight: FontWeight.bold,
                          backgroundColor: Colors.green[100])),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Text(
                        '\$$cartpro_price',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        '\$$cartpro_oldprice',
                        style: TextStyle(fontSize: 17,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    ),

                  ],
                ),
                Row(
                  children: [
                    Text('Color : ',style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    Text(cartpro_color)
                  ],
                ),
                Row(
                  children: [
                    Text('Size : ',style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    Text(cartpro_size)
                  ],
                ),


              ],
            ),
          ],

        ),
      ),
    );
  }
}
