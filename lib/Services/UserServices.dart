import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_mart/Models/CartItemModel.dart';
import 'package:d_mart/Models/UserModel.dart';
class UserService{
  FirebaseFirestore _firestore=FirebaseFirestore.instance;

  createUser(Map<String, dynamic> data) async{
    try{
      await _firestore.collection('eusers').doc(data['uid']).set(data);
      print('User was Created');
    }catch(e){
      print('ErrorL${e.toString()}');
    }
  }
  Future<UserModel> getUserById(String id)=>_firestore.collection('eusers').doc(id).get().then((doc) {
    return UserModel.fromSnapshot(doc);
  });//by these method we are getting all the user data or user model specific to id and we can load it on the ui part by userprovider.usermodel.name

  void addToCart({String userId,CartItemModel cartItemModel}){//it takes data to database
    _firestore.collection('eusers').doc(userId).update({
      'cart':FieldValue.arrayUnion([cartItemModel.toMap()])
    });
  }
  void removeFromCart({String userId, CartItemModel cartItem}){
    _firestore.collection('eusers').doc(userId).update({
      "cart": FieldValue.arrayRemove([cartItem.toMap()])
    });
  }

  Future<List<UserModel>> getUserslist({String userId}) async =>
      _firestore.collection('eusers').get().then((result){
        List<UserModel> userlist=[];
        for(DocumentSnapshot user in result.docs ){
          userlist.add(UserModel.fromSnapshot(user));
        }
        return userlist;
      });
  }


