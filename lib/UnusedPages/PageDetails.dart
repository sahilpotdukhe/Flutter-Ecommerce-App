import 'package:d_mart/UnusedPages/Cart.dart';
import 'package:d_mart/Pages/Homepage.dart';
import 'package:d_mart/UnusedPages/Products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';

class PageDetails extends StatefulWidget {
  final proddetails_name;
  final proddetails_picture;
  final proddetails_oldprice;
  final proddetails_price;
  final proddetails_description;
  final proddetails_fabric;

//constructor
  PageDetails(
      {this.proddetails_name,
      this.proddetails_picture,
      this.proddetails_oldprice,
      this.proddetails_price,
      this.proddetails_description,
      this.proddetails_fabric});

  @override
  _PageDetailsState createState() => _PageDetailsState();
}

class _PageDetailsState extends State<PageDetails> {
  double _rating = 2;

  String dropdownone = 'Size';
  String dropdowntwo = 'Color';
  String dropdownthree = 'Qty';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
          },
          child: Text('D-Mart'),
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
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart()));
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
                child: Image.asset(
                  widget.proddetails_picture,
                  fit: BoxFit.fill,
                ),
              ),
              footer: Container(
                height: 40,
                color: Colors.black,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.proddetails_name,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.proddetails_name,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: HexColor('#d91f2a'),
                    ),
                  )),
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
              // SizedBox(
              //   width: width * 0.01,
              // ),
              Text('$_rating stars',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.yellow[900],
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.yellow[400])),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 2, 0, 6),
            child: Text('Special Price',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.green[900],
                    fontWeight: FontWeight.bold,
                    backgroundColor: Colors.green[100])),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('\$${widget.proddetails_price}',
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                SizedBox(
                  width: 10,
                ),
                Text('\$${widget.proddetails_oldprice}',
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
                          value: dropdownone,
                          dropdownColor: Colors.grey,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                          icon: Icon(Icons.arrow_drop_down),
                          iconEnabledColor: Colors.white,
                          onChanged: (newvalue) {
                            setState(() {
                              dropdownone = newvalue;
                            });
                          },
                          items: <String>['Size', 'S', 'M', 'L', 'XL', 'XXL']
                              .map<DropdownMenuItem<String>>((String value) {
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
                    color: HexColor('#d91f2a'),
                    height: 30,
                    child: Center(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: dropdowntwo,
                          iconEnabledColor: Colors.white,
                          dropdownColor: Colors.grey,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                          icon: Icon(Icons.arrow_drop_down),
                          onChanged: (newvalue) {
                            setState(() {
                              dropdowntwo = newvalue;
                            });
                          },
                          items: <String>[
                            'Color',
                            'White',
                            'Black',
                            'Red',
                            'Maroon',
                            'Grey'
                          ].map<DropdownMenuItem<String>>((String value) {
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
                          items: <String>['Qty', 'One', 'two', 'three']
                              .map<DropdownMenuItem<String>>((String value) {
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
              widget.proddetails_description,
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
                Text(widget.proddetails_name,
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
                Text(widget.proddetails_fabric,
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
            height: height * 0.4,
            child: Products(),
          )
        ],
      ),
      persistentFooterButtons: [
        Row(
          children: [
            Expanded(
              child: RaisedButton(
                onPressed: () {},
                elevation: 0.2,
                child: Text('ADD TO CART',
                    style: TextStyle(fontSize: 16, color: HexColor('#d91f2a'))),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: HexColor('#d91f2a'), width: 2)),
                color: Colors.white,
              ),
            ),
            Expanded(
              child: RaisedButton(
                onPressed: () {},
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
