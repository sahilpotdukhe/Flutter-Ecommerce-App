import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_mart/Models/CartItemModel.dart';

class UserModel {
  static const ID = "id";
  static const NAME = "name";
  static const EMAIL = "email";
  static const PHONE = "phone";
  static const ADDRESS = "address";
  static const CART = "cart";
  static const STRIPE_ID = "stripeId";
  static const UID = "uid";
  static const IMAGE = "image";



  String _name;
  String _email;
  String _id;
  String _uid;
  String _phone;
  String _image;
  String _address;
  String _stripeId;

  double _priceSum = 0;


//  getters
  String get name => _name;
  String get email => _email;
  String get id => _id;
  String get uid => _uid;
  String get phone => _phone;
  String get image => _image;
  String get address => _address;
  String get stripeId => _stripeId;

  //public Variables
  List<CartItemModel> cart;
  double totalCartPrice;

UserModel.fromSnapshot(DocumentSnapshot snapshot){ //A DocumentSnapshot contains data read from a document in your FirebaseFirestore database.
  _name = snapshot.data()[NAME]; //data Contains all the data of this DocumentSnapshot.
  _email = snapshot.data()[EMAIL];
  _phone = snapshot.data()[PHONE];
  _address = snapshot.data()[ADDRESS];
  _id = snapshot.data()[ID];
  _uid = snapshot.data()[UID];
  _image=snapshot.data()[IMAGE]??'https://stratosphere.co.in/img/user.jpg';
  _stripeId=snapshot.data()[STRIPE_ID]?? '';
  cart=_convertCartItems(snapshot.data()[CART]??[]);
  totalCartPrice=snapshot.data()[CART]==null?0:getTotalPrice(cart:snapshot.data()[CART]);
}

List<CartItemModel> _convertCartItems(List cart){
  List<CartItemModel> convertedCart=[];
  for(Map cartItem in cart){
    convertedCart.add(CartItemModel.fromMap(cartItem));
  }
  return convertedCart;
}

  double getTotalPrice({List cart}) {
  if(cart==null){
    return 0;
  }
  for(Map cartItem in cart){
    double i=double.parse(cartItem['quantity'].toString());
    _priceSum +=cartItem['price']*i;
  }
  double total=_priceSum;
  return total;
  }

}
