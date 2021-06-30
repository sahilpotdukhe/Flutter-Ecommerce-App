import 'package:d_mart/Pages/AboutUsPage.dart';
import 'package:d_mart/Pages/AccountInfo.dart';
import 'package:d_mart/Pages/CartPage.dart';
import 'package:d_mart/Pages/CategoryPage.dart';
import 'package:d_mart/Pages/OrdersPage.dart';
import 'package:d_mart/Pages/SearchPage.dart';
import 'package:d_mart/Pages/StartPage.dart';
import 'package:d_mart/Widgets/CategoryWidget.dart';
import 'package:d_mart/Widgets/FeaturedCard.dart';
import 'package:d_mart/Widgets/SimilarProductsCard.dart';
import 'package:d_mart/provider/CategoryProvider.dart';
import 'package:d_mart/provider/productProvider.dart';
import 'package:d_mart/provider/userprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print(height);
    print(width);
    final userProvider = Provider.of<UserProvider>(context);
    final productprovider=Provider.of<ProductProvider>(context);
    final categoryprovider=Provider.of<CategoryProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('E-Mart'),
        elevation: 0,
        backgroundColor: HexColor('#d91f2a'),
        actions: [
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.notifications)
          ),
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()));
              },
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.only(top: 0),
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(userProvider.userModel.name??'',style: TextStyle(fontSize: 20),),
              accountEmail: Text(userProvider.userModel.email),
              currentAccountPicture: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AccountInfo()));
                },
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(userProvider.userModel.image??'https://stratosphere.co.in/img/user.jpg'),
                ),
                ),
                    decoration: BoxDecoration(
                      color: HexColor('#d91f2a'),
              ),
              ),
            InkWell(
              child: ListTile(
                title: Text('Home'),
                leading: Icon(
                  Icons.home,
                  color: Colors.red,
                ),
              ),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
              },
            ),
            InkWell(
              child: ListTile(
                title: Text('My Accounts'),
                leading: Icon(
                  Icons.person,
                  color: Colors.red,
                ),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> AccountInfo()));
              },
            ),
            InkWell(
              child: ListTile(
                title: Text('My Orders'),
                leading: Icon(
                  Icons.shopping_bag,
                  color: Colors.red,
                ),
              ),
              onTap: () async{
                await userProvider.getOrders();
                Navigator.push(context, MaterialPageRoute(builder: (context)=> OrderPage()));
              },
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> CategoryPage()));
              },
              child: ListTile(
                title: Text('Categories'),
                leading: Icon(
                  Icons.dashboard,
                  color: Colors.red,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Favourites'),
                leading: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ),
            ),
            Divider(),
            InkWell(
              child: ListTile(
                title: Text('LogOut'),
                leading: Icon(
                  Icons.settings,
                  color: Colors.red,
                ),
              ),
              onTap: () {
                userProvider.signOutme();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>StartPage()));
              },
            ),
            Divider(),
            InkWell(
              child: ListTile(
                title: Text('About'),
                leading: Icon(
                  Icons.help,
                  color: Colors.red,
                ),
              ),
              onTap: () async{
                await userProvider.getUsers();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutUsPage()));
              },
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          Container(
            height: height*0.06,
            color: HexColor('#d91f2a'),
            child: Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.white
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.search,color: Colors.grey[900],size: 22,),
                    ),
                    Container(
                      width: width*0.76,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(4.0,0,8,3),
                        child: TextField(
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                            hintText: 'Search for products.....',
                            border: InputBorder.none
                          ),
                          onSubmitted: (pattern) async{
                            await productprovider.search(productName: pattern);
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchPage()));
                          },
                        ),
                      ),
                    ),
                    Icon(Icons.mic,color: Colors.grey[900],size: 22,)
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: height*0.02,
            color: HexColor('#d91f2a'),
          ),
          Container(
            width: width,
            height: height * 0.28,
            color: Colors.black,
            child: Swiper.children(
              autoplay: true,
              loop: true,
              pagination: SwiperPagination(
                  builder: DotSwiperPaginationBuilder(
                color: Colors.white,
                activeColor: HexColor('#d91f2a'),
              )),
              children: [
                Container(
                    child: ClipRRect(
                  child: Image.asset(
                    'Assets/m1.jpeg',
                    fit: BoxFit.fill,
                  ),
                )),
                Container(
                    child: ClipRRect(
                  child: Image.asset(
                    'Assets/m2.jpg',
                    fit: BoxFit.fill,
                  ),
                )),
                Container(
                    child: ClipRRect(
                  child: Image.asset(
                    'Assets/p12.jpg',
                    fit: BoxFit.fill,
                  ),
                )),
                Container(
                    child: ClipRRect(
                  child: Image.asset(
                    'Assets/c1.jpg',
                    fit: BoxFit.fill,
                  ),
                )),
                Container(
                    child: ClipRRect(
                  child: Image.asset(
                    'Assets/p23.jpg',
                    fit: BoxFit.fill,
                  ),
                )),
                Container(
                    child: ClipRRect(
                  child: Image.asset(
                    'Assets/p123.jpg',
                    fit: BoxFit.fill,
                  ),
                )),
              ],
            ),
          ),
          Container(
            height: height * 0.05,
            color: Colors.black,
            child: Center(
              child: Text(
                'Categories',
                style: TextStyle(
                    fontSize: height * 0.025,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            height: height*0.18,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoryprovider.categorieslistp.length,
                itemBuilder: (context,index){
                return CategoryWidget(categoryModel:categoryprovider.categorieslistp[index]);
                }
            ),
          ),

          Container(
            height: height * 0.05,
            color: Colors.black,
            child: Center(
              child: Text(
                'Featured Products',
                style: TextStyle(
                    fontSize: height * 0.025,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),

          //  For featured Products
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

          //Products
          Container(
            height: height * 0.05,
            color: Colors.black,
            child: Center(
              child: Text(
                'Similar Products',
                style: TextStyle(
                    fontSize: height * 0.025,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),//makes the whole Screen scrollable
            itemCount: productprovider.productslist.length,
              itemBuilder: (_,index){
              return SimilarProductsCard(
                productModel:productprovider.productslist[index],
              );
              }
          ),

          // Container(
          //   height: height * 0.05,
          //   color: Colors.black,
          //   child: Center(
          //     child: Text(
          //       'Products',
          //       style: TextStyle(
          //           fontSize: height * 0.025,
          //           color: Colors.white,
          //           fontWeight: FontWeight.bold),
          //     ),
          //   ),
          // ),
          // Container(
          //  height: height,
          //   child: Products(),
          // )
        ],
      ),
    );
  }
}
