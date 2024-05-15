import 'package:d_mart/Models/CategoryModel.dart';
import 'package:d_mart/Pages/CartPage.dart';
import 'package:d_mart/Widgets/SimilarProductsCard.dart';
import 'package:d_mart/provider/productProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
class CategoryScreen extends StatelessWidget {
  final CategoryModel categoryModel;

  const CategoryScreen({Key key, this.categoryModel}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
     print(productProvider.productslistByCategory.length);//update(replace with existing data) the productlistbycategory whenever user click on another category
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryModel.categoryname),
        backgroundColor: HexColor('#d91f2a'),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => CartPage()));
              },
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              )),
        ],
      ),
      body: ListView.builder(
          shrinkWrap: true,
          //physics: const NeverScrollableScrollPhysics(),//makes the whole Screen scrollable
          //productlistbycategory contains data of the inex of categorymodel which was pressed
          itemCount: productProvider.productslistByCategory.length,//product list whose category name is equal to the specified clicked category model
          scrollDirection: Axis.vertical,
          itemBuilder: (_,index){
            return SimilarProductsCard(
              productModel:productProvider.productslistByCategory[index],
            );
          }
      ),
      // body: SimilarProductsCard(productModel: productModel,)
    );
  }
}


