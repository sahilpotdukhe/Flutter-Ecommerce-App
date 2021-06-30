import 'package:d_mart/Models/CategoryModel.dart';
import 'package:d_mart/Pages/CategoryScreen.dart';
import 'package:d_mart/Pages/Loading.dart';
import 'package:d_mart/provider/productProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryWidget extends StatelessWidget {
  final CategoryModel categoryModel;

  const CategoryWidget({Key key, this.categoryModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final productprovider=Provider.of<ProductProvider>(context);
    return InkWell(
      onTap: () async{
        await productprovider.loadProductsbyCategory(categoryname: categoryModel.categoryname);
        //await print(productprovider.productslistByCategory.length);
        //these will give the product by category of the specified index which is clicked
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryScreen(categoryModel: categoryModel)));

      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            children: [
              Container(
                width: width*0.25,
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
                            height: height * 0.1,
                            //fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    )),
              ),
              Text(categoryModel.categoryname),
            ],
          ),
      ),
    );
  }
}
