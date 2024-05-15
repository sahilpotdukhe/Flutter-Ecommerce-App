import 'package:d_mart/Pages/Homepage.dart';
import 'package:d_mart/Pages/OrderInfo.dart';
import 'package:d_mart/provider/userprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Orders'),
          backgroundColor: HexColor('#d91f2a'),
        ),
        body:userProvider.orderslist.length==0?
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: height * 0.3,
              width: width ,
              child: Image.asset('Assets/noordersx.png'),
            ),

            SizedBox(
              height: 15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("You haven't placed\n any orders yet.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height:10 ,),
                Text('When you do, your status \nwill appear here.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey
                  ),
                ),
                SizedBox(height: 20,),
                RaisedButton(
                  child: Text('Shop Now',style: TextStyle(
                      color: Colors.white
                  ),),
                  color:HexColor('#d91f2a'),
                  onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
                  },
                )
              ],
            )
          ],
        )
        :ListView.builder(
            itemCount: userProvider.orderslist.length,
            itemBuilder:(_,index){
             return InkWell(
               onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderInfo(orderModel:userProvider.orderslist[index])));
               },
               child:Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: Card(
                   elevation: 2,
                   child: Container(
                     width: width,
                     child: Column(
                       mainAxisSize: MainAxisSize.min,
                       children: [
                         Row(
                           children: [
                             Expanded(
                               child: Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Text(
                                   'Order Summary',
                                   style: TextStyle(
                                     fontSize: 21.0,
                                     color: Colors.red,
                                     fontWeight: FontWeight.bold,
                                   ),
                                 ),
                               ),
                             ),
                             Padding(
                               padding: const EdgeInsets.fromLTRB(8.0,8.0,20,8),
                               child: Container(
                                 decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(20.0),
                                     color: Colors.green[600]
                                 ),
                                 child: Padding(
                                   padding: const EdgeInsets.all(5.0),
                                   child: Text(
                                     'Completed',
                                     style: TextStyle(
                                       fontSize: 18,
                                       color: Colors.white,
                                       fontWeight: FontWeight.bold,
                                     ),
                                   ),
                                 ),
                               ),
                             ),
                           ],
                         ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                             Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Text(
                                 'Order ID: ',
                                 style: TextStyle(
                                   fontSize: 15.0,
                                   fontWeight: FontWeight.bold,
                                 ),
                               ),
                             ),
                           ],
                         ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                             Padding(
                               padding: const EdgeInsets.fromLTRB(15.0,0.0,2,8),
                               child: Text(
                                 userProvider.orderslist[index].id,
                                 style: TextStyle(
                                   color: Colors.grey,
                                   fontSize: 15,
                                 ),
                               ),
                             ),
                           ],
                         ),
                         Row(
                           children: [
                             Expanded(
                               child: Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Text(
                                   'Order Created',
                                   style: TextStyle(
                                     fontSize: 15.0,
                                     fontWeight: FontWeight.bold,
                                   ),
                                 ),
                               ),
                             ),
                             Padding(
                               padding: const EdgeInsets.fromLTRB(8.0,8.0,20,8),
                               child: Text(
                                 userProvider.orderslist[index].createdAt,
                                 style: TextStyle(
                                   fontSize: 15,
                                 ),
                               ),
                             ),
                           ],
                         ),
                         Row(
                           children: [
                             Expanded(
                               child: Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Text(
                                   'Products Ordered',
                                   style: TextStyle(
                                     fontSize: 15.0,
                                     fontWeight: FontWeight.bold,
                                   ),
                                 ),
                               ),
                             ),
                             Padding(
                               padding: const EdgeInsets.fromLTRB(8.0,8.0,20,8),
                               child: Text(
                                 '${userProvider.orderslist[index].cart.length}',
                                 style: TextStyle(
                                   fontSize: 15,
                                 ),
                               ),
                             ),
                           ],
                         ),
                         Row(
                           children: [
                             Expanded(
                               child: Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Text(
                                   'Total',
                                   style: TextStyle(
                                     fontSize: 15.0,
                                     fontWeight: FontWeight.bold,
                                   ),
                                 ),
                               ),
                             ),
                             Padding(
                               padding: const EdgeInsets.fromLTRB(8.0,8.0,20,8),
                               child: Text(
                                 '\$${userProvider.orderslist[index].total}',
                                 style: TextStyle(
                                   fontSize: 15,
                                 ),
                               ),
                             ),
                           ],
                         ),
                         Row(
                           children: [
                             Expanded(
                               child: Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Text(
                                   'Order Status',
                                   style: TextStyle(
                                     fontSize: 15.0,
                                     fontWeight: FontWeight.bold,
                                   ),
                                 ),
                               ),
                             ),
                             Padding(
                               padding: const EdgeInsets.fromLTRB(8.0,8.0,20,8),
                               child: Text(
                               userProvider.orderslist[index].description,
                                 style: TextStyle(
                                   fontWeight: FontWeight.bold,
                                   color: Colors.red,
                                   fontSize: 15,
                                 ),
                               ),
                             ),
                           ],
                         ),
                       ],
                     ),
                   ),
                 ),
               ),
             );
            }
        ),
    );
  }
}

// Text('\$${userProvider.orderslist[index].total}'),
// Text(userProvider.orderslist[index].status),
// Text(userProvider.orderslist[index].createdAt),
// Text(userProvider.orderslist[index].description),
// Divider(thickness: 2,)


// Card(
// child: Column(
// children: [
// Text('\$${_order.total}'),
// Text(_order.description),
// Text(_order.createdAt),
// Text(_order.status),
// ],
// )
//
// );