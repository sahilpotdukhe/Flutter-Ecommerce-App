import 'package:d_mart/UnusedPages/PageDetails.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var product_list = [
    //product_list is the name of the Map
    {
      'name': 'Blazer', //name is the key and blazer is the value of  the key
      'picture': 'Assets/blazer1.jpg',
      'old_price': 200,
      'price': 160,
      'description':'Navy blue single-breasted formal blazer, has a notched lapel, single-breasted with double button closures, long sleeves, three welt pockets on the front, double vented hem on the back.',
      'fabric':'Pure Cotton',
    },
    {
      'name': 'Dress',
      'picture': 'Assets/dress1.jpg',
      'old_price': 320,
      'price': 250,
      'description':'Maroon solid woven tiered maxi dress, has a square neck, short sleeves, concealed zip closure, an attached lining, and flounce hem Comes with a belt.',
      'fabric':'100% Polyester'
    },
    {
      'name': 'Shoe',
      'picture': 'Assets/shoe2.jpeg',
      'old_price': 120,
      'price': 70,
      'description':'Trainers in imitation leather with imitation suede panels, a padded top edge and a tongue and lacing at the front. Imitation leather linings and insoles and smooth rubber soles that are patterned underneath. Some of the polyester content of the trainers is recycled. Height of soles 3.2 cm.',
      'fabric':'100% Polyurethane'
    },
    {
      'name': 'Blazer',
      'picture': 'Assets/blazer2.jpg',
      'old_price': 420,
      'price': 300,
      'description':'Blue and white printed bandhgala blazer, has a mandarin collar, a full button placket, long sleeves, two flap pockets, one chest welt pocket, an attached lining, and a double-vented back hemComes with a pocket square.',
      'fabric':'40% Polyester and 60% viscose rayon'
    },
    {
      'name': 'Shoe',
      'picture': 'Assets/shoe1.jpeg',
      'old_price': 140,
      'price': 100,
      'description':'Flywire: Cables integrate with the laces for adaptive supportWaffle pistons enhance cushioning and responseCushlon foam provides soft yet responsive cushioning with a supportive feel.',
      'fabric':'Textile'
    },
    {
      'name': 'Jeans',
      'picture': 'Assets/jeans.jpg',
      'old_price': 150,
      'price': 85,
      'description':'Black dark wash 5-pocket mid-rise jeans, clean look with no fade, has a button and zip closure, waistband with belt loops Skinny FitStretchable.The model is wearing a size 32.',
      'fabric':'98% cotton, 2% elastane'
    },
    {
      'name': 'Shirt',
      'picture': 'Assets/tshirt.jpg',
      'old_price': 120,
      'price': 60,
      'description':'Black and grey checked casual shirt, has a spread collar, long roll-up sleeves, button placket, curved hem, and 1 patch pocket.Slim fit. The model is wearing a size 40.',
      'fabric':'Cotton'
    },
    {
      'name': 'Informal',
      'picture': 'Assets/informal.jpg',
      'old_price': 500,
      'price': 350,
      'description':'Men pack of two informal shirts .Navy blue solid informal shirt, has a spread collar, long sleeves, button placket, one patch pocket and curved hem White and navy blue striped informal shirt, has a spread collar, long sleeves, button placket, one patch pocket and curved hem.',
      'fabric':'Cotton'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: product_list.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        //physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Singleprod(
            prod_name: product_list[index]['name'],
            prod_picture: product_list[index]['picture'],
            prod_oldprice: product_list[index]['old_price'],
            prod_price: product_list[index]['price'],
            prod_description: product_list[index]['description'],
            prod_fabric: product_list[index]['fabric'],
          );
        });
  }
}

class Singleprod extends StatelessWidget {
  final prod_name;
  final prod_picture;
  final prod_oldprice;
  final prod_price;
  final prod_description;
  final prod_fabric;

  Singleprod(
      {this.prod_name, this.prod_picture, this.prod_oldprice, this.prod_price,this.prod_description,this.prod_fabric});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: Text('Hero1'),
        child: Material(
          child: InkWell(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PageDetails(
                      proddetails_name: prod_name,
                      proddetails_picture: prod_picture,
                      proddetails_oldprice: prod_oldprice,
                      proddetails_price: prod_price,
                      proddetails_description: prod_description,
                      proddetails_fabric: prod_fabric,
                    ))),
            child: GridTile(
              child: Image.asset(
                prod_picture,
                fit: BoxFit.fill,
              ),
              footer: Container(
                color: Colors.white,
                child: ListTile(
                  leading: Text(
                    prod_name,
                    style: TextStyle(
                      color: HexColor('#d91f2a'),
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  title: Text('\$$prod_price'),
                  subtitle: Text(
                    '\$$prod_oldprice',
                    style: TextStyle(decoration: TextDecoration.lineThrough),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
