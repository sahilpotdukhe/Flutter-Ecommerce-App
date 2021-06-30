import 'package:d_mart/Models/productmodel.dart';
import 'package:d_mart/Services/ProductServices.dart';
import 'package:flutter/material.dart';
class ProductProvider with ChangeNotifier{
  ProductServices _productServices=ProductServices();//object
  List<ProductModel> productslist=[];
  List<ProductModel> productslistByCategory = [];
  List<ProductModel> productsSearchedlist=[];

  ProductProvider.initialize(){
    loadProducts();
  }
  loadProducts() async{
    productslist=await _productServices.getProducts();
    notifyListeners();
  }
  Future loadProductsbyCategory({String categoryname}) async{
    productslistByCategory=await _productServices.getProductsbyCategory(categoryname: categoryname);
    notifyListeners();
  }
  Future search({String productName}) async{
    productsSearchedlist=await _productServices.searchProducts(productname: productName);
    notifyListeners();
  }

}