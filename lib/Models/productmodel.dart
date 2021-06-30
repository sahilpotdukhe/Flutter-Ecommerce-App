import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel{
  static const ID='id';
  static const NAME = 'name';
  static const IMAGE = 'Images';
  static const PRICE = 'Price';
  static const ORIGINALPRICE = 'originalprice';
  static const CATEGORY = 'category';
  static const QUANTITY = 'quantity';
  static const BRAND = 'brand';
  static const SIZES = 'Sizes';
  static const COLORS = 'Colors';
  static const FEATURED = 'featured';
  static const ONSALE = 'sale';
  static const DESCRIPTION='description';
  static const FABRIC='fabric';




  //private Variables
  String _id;
  String _name;
  String _image;
  String _category;
  String _brand;
  int _quantity;
  double _price;
  List _colors;
  List _sizes;
  bool _sale;
  bool _featured;
  String _description;
  double _originalprice;
  String _fabric;


  //getter function
  String get id=>_id;
  String get name => _name;
  String get image => _image;
  String get brand => _brand;
  String get category => _category;
  int get quantity => _quantity;
  double get price => _price;
  double get originalprice => _originalprice;
  List get colors => _colors;
  List get sizes => _sizes;
  bool get sale =>_sale;
  bool get featured=>_featured;
  String get description=>_description;
  String get fabric => _fabric;


  //named Constructor
  ProductModel.fromSnapshot(DocumentSnapshot snapshot){
    _id=snapshot.data()[ID];
    _brand = snapshot.data()[BRAND];
    _price = snapshot.data()[PRICE];
    _category = snapshot.data()[CATEGORY];
    _colors = snapshot.data()[COLORS];
    _sizes = snapshot.data()[SIZES];
    _name = snapshot.data()[NAME];
    _image = snapshot.data()[IMAGE];
    _quantity=snapshot.data()[QUANTITY];
    _featured=snapshot.data()[FEATURED];
    _sale=snapshot.data()[ONSALE];
    _description=snapshot.data()[DESCRIPTION];
    _originalprice=snapshot.data()[ORIGINALPRICE];
    _fabric=snapshot.data()[FABRIC];

  }
}