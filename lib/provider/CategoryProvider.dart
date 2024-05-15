import 'package:d_mart/Models/CategoryModel.dart';
import 'package:d_mart/Services/CategoryService.dart';
import 'package:flutter/cupertino.dart';

class CategoryProvider with ChangeNotifier{
  CategoryServices _categoryServices=CategoryServices();
  List<CategoryModel> categorieslistp=[];

  CategoryProvider.initialize(){
    loadcategories();
  }

   loadcategories() async{
    categorieslistp=await _categoryServices.getCategories();
    notifyListeners();
   }
}