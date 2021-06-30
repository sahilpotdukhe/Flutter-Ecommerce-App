import 'package:d_mart/Models/productmodel.dart';
import 'package:d_mart/UnusedPages/Cart.dart';
import 'package:d_mart/Pages/CartPage.dart';
import 'package:d_mart/Pages/Homepage.dart';
import 'package:d_mart/Pages/Loading.dart';
import 'package:d_mart/Widgets/FeaturedCard.dart';
import 'package:d_mart/provider/appProvider.dart';
import 'package:d_mart/provider/productProvider.dart';
import 'package:d_mart/provider/userprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
class ProductDetails extends StatefulWidget {
  final ProductModel productModel;

  const ProductDetails({Key key, this.productModel}) : super(key: key);
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final _key = GlobalKey<ScaffoldState>();
  bool isPressed=false;
  double _rating = 2;
  String _sizesdropdown = '';
  String _colorsdropdown = '';
  int dropdownthree = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _sizesdropdown=widget.productModel.sizes[0];
    _colorsdropdown=widget.productModel.colors[0];
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final productprovider=Provider.of<ProductProvider>(context);
    final userprovider=Provider.of<UserProvider>(context);
    final appProvider=Provider.of<AppProvider>(context);
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: InkWell(
          onTap: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
          },
          child: Text('E-Mart'),
        ),
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
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CartPage()));
              },
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ))
        ],
      ),
      body: ListView(
        children: [
          Container(
            height: height * 0.5,
            width: width,
            child: GridTile(
              child: Container(
                child: ClipRRect(
                    child: Stack(
                      children: [
                        Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: Loading(),
                            )),
                        Image.network(
                            widget.productModel.image,
                          height: height * 0.5,
                          width: width,
                          fit: BoxFit.fill,
                        ),
                      ],
                    )),
              ),
              footer: Container(
                height: 40,
                color: Colors.black,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.productModel.name,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.productModel.name,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: HexColor('#d91f2a'),
                ),
              )),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 2, 0, 6),
            child: Text('Special Price',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.green[900],
                    fontWeight: FontWeight.bold,
                    backgroundColor: Colors.green[100])),
          ),
          Row(
            children: [
              RatingBar.builder(
                initialRating: 2,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 30,
                itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
              ),
              Text('$_rating stars',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.yellow[900],
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.yellow[400])),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('\$${widget.productModel.price}',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                SizedBox(
                  width: 10,
                ),
                Text('\$${widget.productModel.originalprice}',
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough))
              ],
            ),
          ),
          Container(
            width: width,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.black,
                    height: 30,
                    child: Center(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: _colorsdropdown,
                          dropdownColor: Colors.grey,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                          icon: Icon(Icons.arrow_drop_down),
                          iconEnabledColor: Colors.white,
                          onChanged: (newvalue) {
                            setState(() {
                              _colorsdropdown = newvalue;
                            });
                          },
                          items: widget.productModel.colors
                          .map<DropdownMenuItem<String>>((value){
                            return DropdownMenuItem<String>(
                              value: value,
                                child: Text(value),
                            );
                          }).toList(),
                          // items: <String>['Size', 'S', 'M', 'L', 'XL', 'XXL']
                          //     .map<DropdownMenuItem<String>>((String value) {
                          //   return DropdownMenuItem<String>(
                          //     value: value,
                          //     child: Text(value),
                          //   );
                          // }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: HexColor('#d91f2a'),
                    height: 30,
                    child: Center(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: _sizesdropdown,
                          iconEnabledColor: Colors.white,
                          dropdownColor: Colors.grey,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                          icon: Icon(Icons.arrow_drop_down),
                          onChanged: (newvalue) {
                            setState(() {
                              _sizesdropdown = newvalue;
                            });
                          },
                          items: widget.productModel.sizes
                              .map<DropdownMenuItem<String>>((value){
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.green[900],
                    height: 30,
                    child: Center(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: dropdownthree,
                          dropdownColor: Colors.grey,
                          iconEnabledColor: Colors.white,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                          icon: Icon(Icons.arrow_drop_down),
                          elevation: 16,
                          onChanged: (newvalue) {
                            setState(() {
                              dropdownthree = newvalue;
                            });
                          },
                          items: <int>[1,2,3,4,5]
                              .map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text('${value}'),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Product Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0, 6, 2),
            child: Text(
              widget.productModel.description,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Divider(
            thickness: 1,
            color: Colors.black45,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 3, 0, 2),
            child: Row(
              children: [
                Text(
                  'Product Name         ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(widget.productModel.name,
                    style: TextStyle(
                      fontSize: 15,
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 3, 0, 2),
            child: Row(
              children: [
                Text(
                  'Product Material    ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(widget.productModel.fabric??'Sahil',
                    style: TextStyle(
                      fontSize: 15,
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 3, 0, 2),
            child: Row(
              children: [
                Text(
                  'Product Condition  ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                GlowText('New',
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.red,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Divider(
            thickness: 6,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Similar Products',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: height*0.42,

            child: ListView.builder(
                shrinkWrap: true,
                //physics: const NeverScrollableScrollPhysics(),//makes the whole Screen scrollable
                itemCount: productprovider.productslist.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_,index){
                  return FeaturedCard(
                    productModel:productprovider.productslist[index],
                  );
                }
            ),
          ),
        ],
      ),
      persistentFooterButtons: [
        Row(
          children: [
            Expanded(
              child: isPressed?
              RaisedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CartPage()));
                  },
                  child: Text('GO TO CART',
                      style: TextStyle(fontSize: 16, color: HexColor('#d91f2a'))),
                elevation: 0.2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: HexColor('#d91f2a'), width: 2)),
                color: Colors.white,
                  )
                  :RaisedButton(
                child: appProvider.isLoading?Loading():Text('ADD TO CART',
                    style: TextStyle(fontSize: 16, color: HexColor('#d91f2a'))),
                onPressed: () async{
                  setState(() {
                    isPressed=true;
                  });
                  appProvider.changeIsLoading();
                  bool success=await userprovider.addToCartP(
                    productModel: widget.productModel,
                    color: _colorsdropdown,
                    size: _sizesdropdown,
                    quantity:dropdownthree,
                  );
                  if(success==true){
                    _key.currentState.showSnackBar(SnackBar(content: Text('ADDED TO CART'),duration: Duration(seconds: 1 ),));
                    userprovider.reloadUserModel();
                    appProvider.changeIsLoading();
                  }else{
                    _key.currentState.showSnackBar(SnackBar(content: Text('Not added to cart'),));
                    appProvider.changeIsLoading();
                  }
                },
                elevation: 0.2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: HexColor('#d91f2a'), width: 2)),
                color: Colors.white,
              ),
            ),
            Expanded(
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CartPage()));
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'BUY NOW',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                color: HexColor('#d91f2a'),
              ),
            ),
          ],
        )
      ],
    );
  }
}
