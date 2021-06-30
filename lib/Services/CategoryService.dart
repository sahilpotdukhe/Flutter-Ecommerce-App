import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_mart/Models/CategoryModel.dart';

class CategoryServices {
  FirebaseFirestore _firestore=FirebaseFirestore.instance;

  Future<List<CategoryModel>> getCategories() async=>
      _firestore.collection('categories').get().then((result){
        List<CategoryModel> categorieslist=[];
        for(DocumentSnapshot category in result.docs){
          categorieslist.add(CategoryModel.fromSnapshot(category));
  }
        return categorieslist;

});
}