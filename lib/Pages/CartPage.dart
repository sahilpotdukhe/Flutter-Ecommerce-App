import 'package:d_mart/Models/CartItemModel.dart';
import 'package:d_mart/Pages/Homepage.dart';
import 'package:d_mart/Pages/Loading.dart';
import 'package:d_mart/Services/OrderServices.dart';
import 'package:d_mart/provider/appProvider.dart';
import 'package:d_mart/provider/userprovider.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final _key = GlobalKey<ScaffoldState>();
  OrderServices _orderServices=OrderServices();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final appProvider = Provider.of<AppProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    return (userProvider.userModel.totalCartPrice==0)?
    Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
        backgroundColor: HexColor('#d91f2a'),
        actions: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.search, color: Colors.white,)),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: height*0.2,),
          Center(
            child: Container(
              height: height*0.4,
                width: width*0.6,
              //  color: Colors.black,
                child: Image.asset('Assets/emptycart.png',)
            ),
          ),
          Text('Your cart is empty!',
            style: TextStyle(
            fontSize: height*0.03,
              fontWeight: FontWeight.bold
          ),),
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

    )
    :
    Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text('My Cart'),
        backgroundColor: HexColor('#d91f2a'),
        actions: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.search, color: Colors.white,)),
        ],
      ),
      body:
      appProvider.isLoading ? Loading()
          : ListView.builder(
          itemCount: userProvider.userModel.cart.length,
          itemBuilder: (_, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                  elevation: 2,
                  child: Container(
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
                                  userProvider.userModel.cart[index].image,
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
                        userProvider.userModel.cart[index].name,
                        style: TextStyle(
                            fontSize: height*0.025, fontWeight: FontWeight.bold, color:HexColor('#d91f2a')),
                      ),
                    ),

                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child: Text(
                          '\$${userProvider.userModel.cart[index].price}',
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
                      Text(userProvider.userModel.cart[index].color)
                    ],
                  ),
                  Row(
                    children: [
                      Text('Size : ', style: TextStyle(
                          fontSize:  height*0.02, fontWeight: FontWeight.bold)),
                      Text(userProvider.userModel.cart[index].size)
                    ],
                  ),
                          Row(
                            children: [
                              Text('Quantity : ', style: TextStyle(
                                  fontSize:  height*0.02, fontWeight: FontWeight.bold)),
                              Text('${userProvider.userModel.cart[index].quantity}')
                            ],
                          ),
                  RaisedButton(
                    color: Colors.white,
                    child: Row(
                      children: [
                        Text('Remove',style: TextStyle(fontSize:  height*0.02),),
                        Icon(Icons.delete,size:  height*0.02,),
                      ],
                    ),
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  title: Center(
                                    child: Text('Remove Item',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                  content: Text(
                                      'Are you sure you want to remove this item?'),
                                  actions: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: RaisedButton(
                                              child: Text('Cancel'),
                                              onPressed: () {
                                                Navigator.pop(context, true);
                                              },
                                            color: Colors.white,
                                          ),
                                        ),
                                        Expanded(
                                          child: RaisedButton(
                                            color: Colors.white,
                                            child: Text('Remove',
                                              style: TextStyle(
                                                  color: Colors.red),),
                                            onPressed: () async {
                                              Navigator.pop(context,true);
                                              appProvider.changeIsLoading();
                                              bool success = await userProvider.removeFromCart(
                                                  cartItem: userProvider.userModel.cart[index]);
                                              if (success) {
                                                userProvider.reloadUserModel();
                                                print('Item removed');
                                                _key.currentState.showSnackBar(
                                                    SnackBar(content: Text(
                                                        'Item removed from cart')));
                                                appProvider.changeIsLoading();
                                                return;
                                              } else {
                                                appProvider.changeIsLoading();
                                              }

                                            },
                                          ),
                                        )
                                        ,
                                      ]
                                      ,
                                    )
                                  ]
                              );
                            }
                        );
                      }
                  )
              ],
            ),
            ],

            ),
            ),
            ),
            );
          }
      ),
      persistentFooterButtons: [
        Row(
          children: [
            Expanded(
              child: Text('Total : \$${userProvider.userModel.totalCartPrice}',
              style: TextStyle(
                  fontSize: 24,
                color: Colors.green[800],
                fontWeight: FontWeight.bold
              ),
              ),
            ),
            Expanded(
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'BUY NOW',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                color: HexColor('#d91f2a'),
                onPressed: () {
                  if(userProvider.userModel.totalCartPrice==0){
                    showDialog(
                        context: context,
                        builder: (BuildContext context){
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)
                            ),
                            child: Container(
                              height: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          'Your cart is empty!',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                    );
                    return;
                  }
                  showDialog(
                      context: context,
                      builder: (BuildContext context){
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)
                          ),
                          child: Container(
                            height: 200,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('You will be charged \$${userProvider.userModel.totalCartPrice} upon delivery!',
                                  textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    width: width*0.7,
                                    child: RaisedButton(
                                      child: Text('Confirm',style: TextStyle(color: Colors.white),),
                                      color: HexColor('#d91f2a'),
                                      onPressed: () async{
                                        Navigator.pop(context,true);
                                        var uuid=Uuid();
                                        String id=uuid.v4();
                                        _orderServices.createOrder(
                                          userId: userProvider.user.uid,
                                          id: id,
                                          description: 'Out for delivery',
                                          status: 'Complete',
                                          totalCartPrice: userProvider.userModel.totalCartPrice,
                                          cart: userProvider.userModel.cart
                                        );
                                        for(CartItemModel cartItem in userProvider.userModel.cart){
                                          bool success=await userProvider.removeFromCart(cartItem: cartItem);
                                          if(success){
                                            userProvider.reloadUserModel();
                                            _key.currentState.showSnackBar(SnackBar(content: Text('Check out in orders')));
                                          }else{
                                            print('Item was not removed');
                                          }
                                        }
                                        _key.currentState.showSnackBar(SnackBar(content: Text('Order Placed')));
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: width*0.7,
                                    child: RaisedButton(
                                      child: Text('Reject'),
                                      onPressed: (){
                                        Navigator.pop(context,true);                                      },
                                    ),
                                  )

                                ],
                              ),
                            ),
                          ),
                        );
                      }
                  );
                },

              ),
            ),
          ],
        ),

      ],
    );

  }

}
