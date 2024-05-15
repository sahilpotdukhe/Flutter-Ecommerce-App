import 'package:d_mart/Models/CategoryModel.dart';
import 'package:d_mart/Pages/CartPage.dart';
import 'package:d_mart/Pages/ProductDetails.dart';
import 'package:d_mart/Widgets/SimilarProductsCard.dart';
import 'package:d_mart/provider/productProvider.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
class CategoryScreen2ndway extends StatelessWidget {
  final CategoryModel categoryModel;

  const CategoryScreen2ndway({Key key, this.categoryModel}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
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
        body:  ListView(
          children:[
         // Text(categoryModel.categoryname),
            Column(
              children:productProvider.productslistByCategory
                  .map((item) => GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails(productModel: item,)));
                  },

                  child: SimilarProductsCard(productModel: item,)
              ))
                  .toList(),
            ),
          ]

        ),
    );
  }
}


