import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_mart/Models/CartItemModel.dart';
import 'package:d_mart/Models/OrderModel.dart';
import 'package:intl/intl.dart';

class OrderServices{
  FirebaseFirestore _firestore=FirebaseFirestore.instance;

  void createOrder({String userId,String id,String description,String status,List<CartItemModel> cart,double totalCartPrice}){
    List<Map> convertedCart=[];

    for(CartItemModel itemModel in cart){
      convertedCart.add(itemModel.toMap());
    }
    _firestore.collection('orders').doc(id).set({
      'userId':userId,
      'id':id,
      'cart':convertedCart,
      'total':totalCartPrice,
      'createdAt':Getdate(),
      'description':description,
      'status':status,
    });
  }

  Future<List<OrderModel>> getUserOrders({String userId}) async =>
      _firestore.collection('orders').where('userId',isEqualTo: userId).orderBy("createdAt", descending: true).get().then((result){
        List<OrderModel> orderslist=[];
        for(DocumentSnapshot order in result.docs ){
          orderslist.add(OrderModel.fromSnapshot(order));
        }
        return orderslist;
      });

  Getdate() {
    DateTime now=DateTime.now();
    var formattedDate = DateFormat.yMMMd().add_jm().format(now);
    return formattedDate;
  }
}