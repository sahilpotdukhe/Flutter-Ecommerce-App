import 'package:d_mart/Models/productmodel.dart';
import 'package:d_mart/Pages/Loading.dart';
import 'package:d_mart/Pages/ProductDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class FeaturedCard extends StatelessWidget {
  final ProductModel productModel;

  const FeaturedCard({Key key, this.productModel}) : super(key: key);//named constructor

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0,6,10.0,0),
      child: InkWell(
        onTap:(){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetails(productModel:productModel)));
        },
        child: Card(
          elevation:2 ,
          shadowColor: Colors.grey,
          child: Column(
            children: [
              Container(
                child: Padding(
                  padding:const EdgeInsets.fromLTRB(8.0,8,8.0,6),
                  child: Container(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Stack(
                          children: [
                            Positioned.fill(
                                child: Align(
                                 alignment: Alignment.center,
                                   child: Loading(),
                            )),
                            Image.network(
                              productModel.image,
                              height: height * 0.3,
                              width: width * 0.6,
                              fit: BoxFit.fill,
                            ),
                          ],
                        )),
                  ),
                ),
              ),
              Container(
                child: Text(
                  '${productModel.name}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 19.0,
                    color: HexColor('#d91f2a'),
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text('\$${productModel.price}',style: TextStyle(
                      fontWeight: FontWeight.bold,
                       fontSize: 18,
                    ),),
                  ),
                  SizedBox(width: 10.0,),
                  Text('\$${productModel.originalprice}',style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
