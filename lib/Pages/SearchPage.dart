import 'package:d_mart/Pages/CartPage.dart';
import 'package:d_mart/Pages/ProductDetails.dart';
import 'package:d_mart/Widgets/SimilarProductsCard.dart';
import 'package:d_mart/provider/productProvider.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final productprovider=Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Result'),
        centerTitle: true,
        backgroundColor: HexColor('#d91f2a'),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => CartPage()));
              },
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ))
        ],
      ),
      body:productprovider.productsSearchedlist.length==0
          ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
           Image.asset('Assets/noresultx.png'),
            SizedBox(
            height: 15,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('No products Found',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              ),
              Text('Try different keywords',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey
                ),
              ),
            ],
          )
        ],
      ) :
          ListView.builder(
            itemCount: productprovider.productsSearchedlist.length,
              itemBuilder:(context,index){
              return GestureDetector(
                child: SimilarProductsCard(productModel: productprovider.productsSearchedlist[index],),
                onTap: () async{
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetails(productModel: productprovider.productsSearchedlist[index],)));
                },
              );
              }
          )
    );
  }
}
