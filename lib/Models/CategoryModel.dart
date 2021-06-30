import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  static const CATEGORYNAME = "category";
  static const IMAGE = "image";

  String _categoryname;
  String _image;

  //  getters
  String get categoryname => _categoryname;
  String get image => _image;

  CategoryModel.fromSnapshot(DocumentSnapshot snapshot){
    _categoryname = snapshot.data()[CATEGORYNAME];
    _image = snapshot.data()[IMAGE];
  }
}