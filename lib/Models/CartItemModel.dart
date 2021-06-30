
class CartItemModel{
  static const ID='id';
  static const NAME='name';
  static const IMAGE = "image";
  static const PRODUCT_ID = "productId";
  static const PRICE = "price";
  static const SIZE = "size";
  static const COLOR = "color";
  static const QUANTITY = "quantity";

  String _id;
  String _name;
  String _image;
  String _productId;
  String _size;
  String _color;
  double _price;
  int _quantity;

  //  getters
  String get id => _id;
  String get name => _name;
  String get image => _image;
  String get productId => _productId;
  String get size => _size;
  String get color => _color;
  double get price => _price;
  int get quantity => _quantity;

  CartItemModel.fromMap(Map data){
    _id=data[ID];
    _name =  data[NAME];
    _image =  data[IMAGE];
    _productId = data[PRODUCT_ID];
    _price = data[PRICE];
    _size = data[SIZE];
    _color = data[COLOR];
    _quantity=data[QUANTITY];
  }
  Map toMap() => {
    ID: _id,//same as 'id':_id
    IMAGE: _image,//same as 'image':_image
    NAME: _name,
    PRODUCT_ID: _productId,
    PRICE: _price,
    SIZE: _size,
    COLOR: _color,
    QUANTITY:_quantity,
  };
}