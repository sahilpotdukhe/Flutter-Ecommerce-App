import 'package:d_mart/Models/OrderModel.dart';
import 'package:d_mart/Pages/Loading.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class OrderInfo extends StatelessWidget {
  final OrderModel orderModel;

  const OrderInfo({Key key, this.orderModel}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Info'),
        backgroundColor: HexColor('#d91f2a'),
        actions: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.search, color: Colors.white,)),
        ],
      ),
      body: ListView.builder(
          itemCount:orderModel.cart.length,
          itemBuilder: (_, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 2,
                child: Container(
                  height: height * 0.2,
                  child: Row(
                    children: [
                      ClipRRect(
                          child: Stack(
                            children: [
                              Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Loading(),
                                  )),
                              Image.network(
                                orderModel.cart[index].image,
                                width: width*0.4,
                                fit: BoxFit.fill,
                              ),
                            ],
                          )),
                      SizedBox(width: width*0.1,),
                      Column(
                        children: [
                          Center(
                            child: Text(
                             orderModel.cart[index].name,
                              style: TextStyle(
                                  fontSize: height*0.025, fontWeight: FontWeight.bold, color:HexColor('#d91f2a')),
                            ),
                          ),

                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(0),
                                child: Text(
                                  '\$${orderModel.cart[index].price}',
                                  style: TextStyle(
                                      fontSize: height*0.025, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8.0,0,0,0),
                                child: Text('Special Price',
                                    style: TextStyle(
                                        fontSize: height*0.02,
                                        color: Colors.green[900],
                                        fontWeight: FontWeight.bold,
                                        backgroundColor: Colors.green[100])),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Color : ', style: TextStyle(
                                  fontSize: height*0.02, fontWeight: FontWeight.bold)),
                              Text(orderModel.cart[index].color)
                            ],
                          ),
                          Row(
                            children: [
                              Text('Size : ', style: TextStyle(
                                  fontSize:  height*0.02, fontWeight: FontWeight.bold)),
                              Text(orderModel.cart[index].size)
                            ],
                          ),
                          Row(
                            children: [
                              Text('Quantity : ', style: TextStyle(
                                  fontSize:  height*0.02, fontWeight: FontWeight.bold)),
                              Text('${orderModel.cart[index].quantity}')
                            ],
                          ),
                        ],
                      ),
                    ],

                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}
