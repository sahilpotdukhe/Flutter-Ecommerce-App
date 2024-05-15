import 'package:d_mart/Models/CartItemModel.dart';
import 'package:d_mart/Models/OrderModel.dart';
import 'package:d_mart/Models/UserModel.dart';
import 'package:d_mart/Models/productmodel.dart';
import 'package:d_mart/Services/OrderServices.dart';
import 'package:d_mart/Services/UserServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

enum Status{Uninitialized, Authenticated,Authenticating,Unauthenticated}

class UserProvider with ChangeNotifier{
  UserService _userService=UserService();//making object of UserService class
  OrderServices _orderServices=OrderServices();

  FirebaseAuth _auth;
  User _user;
  UserModel _userModel;
  Status _status=Status.Uninitialized;

  //getter values
  Status get status => _status;
  User get user =>_user;
  UserModel get userModel=>_userModel;

  //public variables
  List<OrderModel> orderslist=[];
  List<UserModel> userlist=[];

  //Constructor
UserProvider.initialize() :_auth =FirebaseAuth.instance{
  _auth.authStateChanges().listen(_onStateChangedme);
}
Future<bool> signInme(String email,String password) async{
  try{
    _status=Status.Authenticating;
    notifyListeners();//it goes to main.dart and update the data with new status value
    await _auth.signInWithEmailAndPassword(email: email, password: password).then((value) async{
      _userModel=await _userService.getUserById(value.user.uid);
      notifyListeners();
    });
    return true;
    }catch(e){
    _status=Status.Unauthenticated;
    notifyListeners();
    print(e.toString());
    return false;
  }
}
Future<bool> signUpme(String name,String email,String password) async{
  try{
    _status=Status.Authenticating;
    notifyListeners();
    await _auth.createUserWithEmailAndPassword(email: email, password: password)
    .then((value) async{
      _userService.createUser({
        'name':name,
        'email':email,
        'password':password,
        'uid':value.user.uid
      });
      _userModel=await _userService.getUserById(value.user.uid);//from these we are getting the whole user model of particular id of the current user
      notifyListeners();
      });
    return true;
  }catch(e){
      _status=Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
  }
}
Future signOutme() async{
  _status=Status.Unauthenticated;
  notifyListeners();
  _auth.signOut();
}

  Future<void> _onStateChangedme(User user) async{
    if(user==null){
      _status=Status.Unauthenticated;
    }else{
      _user=user;
     _userModel = await _userService.getUserById(user.uid);
      _status=Status.Authenticated;
    }
    notifyListeners();
  }

  Future<bool> addToCartP({ProductModel productModel,String size,String color,int quantity}) async{
  try{
    var uuid=Uuid();
    String cartItemId=uuid.v4();

    Map cartItem={
      'id':cartItemId,
      'name':productModel.name,
      'image':productModel.image,
      'productId':productModel.id,
      'price':productModel.price,
      'size':size,
      'color':color,
      'quantity':quantity,
    };

    CartItemModel itemModel=CartItemModel.fromMap(cartItem);
    print('Cart items are: ${cartItem.toString()}');
    _userService.addToCart(userId: _user.uid,cartItemModel: itemModel);
    return true;
  }catch(e){
    print("THE ERROR ${e.toString()}");
    return false;
  }
  }


  Future<bool> removeFromCart({CartItemModel cartItem})async{
    print("THE PRODUCT IS: ${cartItem.toString()}");

    try{
      _userService.removeFromCart(userId: _user.uid, cartItem: cartItem);
      return true;
    }catch(e){
      print("THE ERROR ${e.toString()}");
      return false;
    }
  }

  getOrders() async{
  orderslist=await _orderServices.getUserOrders(userId: _user.uid);
  notifyListeners();
  }
  getUsers() async{
    userlist=await _userService.getUserslist();
    notifyListeners();
  }
  Future<void> reloadUserModel()async{
    _userModel = await _userService.getUserById(user.uid);
    notifyListeners();
  }



}