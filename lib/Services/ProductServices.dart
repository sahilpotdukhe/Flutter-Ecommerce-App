import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_mart/Models/productmodel.dart';

class ProductServices {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ProductModel>> getProducts() async =>
      _firestore.collection('products').get().then((result) {
        List<ProductModel> productslist = []; //list of products
        for (DocumentSnapshot eachproduct in result.docs) { //docs =Gets a list of all the documents included in this snapshot.
          //It adds each document of collection 'product in product list
          productslist.add(ProductModel.fromSnapshot(eachproduct));
        }
        return productslist;
      });

  //for only  products by category
  Future<List<ProductModel>> getProductsbyCategory({String categoryname}) async =>
      _firestore
          .collection('products')
          .where('category', isEqualTo: categoryname)
          .get()
          .then((result) {
        List<ProductModel> productslist = []; //list of products
        for (DocumentSnapshot eachproduct in result.docs) {
          //It adds each document of collection 'product in product list
          productslist.add(ProductModel.fromSnapshot(eachproduct));
        }
        return productslist;
      });

  Future<List<ProductModel>> searchProducts({String productname}) {
    //code to conert the first character to uppercase incase the user starts with lowercase
    //as our all products first character is capital
    String searchkey = productname[0].toUpperCase() + productname.substring(1);
    return _firestore
        .collection('products')
        .orderBy('name')
        .startAt([searchkey])
        .endAt([searchkey + '\uf8ff'])
        .get()
        .then((result) {
          List<ProductModel> productslist = [];
          for (DocumentSnapshot eachproduct in result.docs) {
            //It adds each document of collection 'product in product list
            productslist.add(ProductModel.fromSnapshot(eachproduct));
          }
          return productslist;
        });
  }
}
