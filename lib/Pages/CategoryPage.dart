import 'package:d_mart/Pages/CartPage.dart';
import 'package:d_mart/Pages/CategoryWidget2.dart';
import 'package:d_mart/provider/CategoryProvider.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryprovider = Provider.of<CategoryProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Categories'),
          elevation: 0,
          backgroundColor: HexColor('#d91f2a'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CartPage()));
                },
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ))
          ],
        ),
        body: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: categoryprovider.categorieslistp.length,
          itemBuilder: (context, index) {
            return CategoryWidget2(categoryModel: categoryprovider.categorieslistp[index]);
          },
        ));
  }
}
