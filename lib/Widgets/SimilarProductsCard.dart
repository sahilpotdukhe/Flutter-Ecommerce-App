import 'package:d_mart/Models/productmodel.dart';
import 'package:d_mart/Pages/Loading.dart';
import 'package:d_mart/Pages/ProductDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:hexcolor/hexcolor.dart';
class SimilarProductsCard extends StatelessWidget {
  final ProductModel productModel;

  const SimilarProductsCard({Key key, this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    //final mediadata=MediaQuery.of(context).copyWith(textScaleFactor: 1.0);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap:(){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetails(productModel:productModel)));
        },
        child: Card(
          elevation:2 ,
          shadowColor: Colors.grey,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Stack(
                      children: [
                        Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: Loading(),
                            )
                        ),
                        Image.network(
                          productModel.image,
                          height: height * 0.2,
                          width: width * 0.45,
                          fit: BoxFit.fill,
                        )
                      ],
                    ),
                  ),
                ),
              ),


               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   Padding(
                     padding: const EdgeInsets.all(0),
                     child: Text(
                        '${productModel.name}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 21,
                          color: HexColor('#d91f2a'),
                        ),
                      ),
                   ),
                   SizedBox(height: height*0.01,),
                   Padding(
                     padding: const EdgeInsets.all(0),
                     child: Row(
                       children: [
                         Text('Brand:',
                           style: TextStyle(
                           fontWeight: FontWeight.bold,
                           fontSize: 17,
                         ),),
                         Text('${productModel.brand}',
                           style: TextStyle(
                           fontSize: 14,
                         ),),
                       ],
                     ),
                   ),
                   //SizedBox(height: height*0.01,),

                   Padding(
                     padding: const EdgeInsets.only(top: 6.0),
                     child: Row(
                       children: [
                         Padding(
                           padding: const EdgeInsets.all(0.0),
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
                         ),)
                       ],
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.fromLTRB(1, 2, 0, 6),
                     child: Text('Special Price',
                         style: TextStyle(
                             fontSize: 15,
                             color: Colors.green[900],
                             fontWeight: FontWeight.bold,
                             backgroundColor: Colors.green[100])),
                   ),
                   Padding(
                     padding: const EdgeInsets.fromLTRB(1, 2, 0, 6),
                     child: GlowText('ON SALE',
                         style: TextStyle(
                             fontSize: 18,
                             color: Colors.red,
                             fontWeight: FontWeight.bold,
                             ),
                     )
                   ),
                   SizedBox(height: height*0.04,),
                 ],
               ),


            ],
          ),
        ),
      ),
    );
  }
}
