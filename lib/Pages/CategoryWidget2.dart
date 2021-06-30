import 'package:d_mart/Models/CategoryModel.dart';
import 'package:d_mart/Pages/CategoryScreen.dart';
import 'package:d_mart/Pages/Loading.dart';
import 'package:d_mart/provider/productProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryWidget2 extends StatelessWidget {
  final CategoryModel categoryModel;

  const CategoryWidget2({Key key, this.categoryModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final productprovider = Provider.of<ProductProvider>(context);
    return InkWell(
        onTap: () async {
          await productprovider.loadProductsbyCategory(
              categoryname: categoryModel.categoryname);
          //await print(productprovider.productslistByCategory.length);
          //these will give the product by category of the specified index which is clicked
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CategoryScreen(categoryModel: categoryModel)));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 2,
            child: Column(
              children: [
                Container(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Stack(
                        children: [
                          Positioned.fill(
                              child: Align(
                            alignment: Alignment.center,
                            child: Loading(),
                          )),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              categoryModel.image,
                              height: height * 0.12,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      )),
                ),
                SizedBox(height: 18,),
                Text(categoryModel.categoryname,style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),),
              ],
            ),
          ),
        ));
  }
}
