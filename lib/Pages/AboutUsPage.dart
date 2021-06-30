import 'package:d_mart/Services/UserServices.dart';
import 'package:d_mart/provider/CategoryProvider.dart';
import 'package:d_mart/provider/productProvider.dart';
import 'package:d_mart/provider/userprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key key}) : super(key: key);

  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final productprovider=Provider.of<ProductProvider>(context);
    final categoryprovider=Provider.of<CategoryProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        backgroundColor: HexColor('#d91f2a'),
      ),
      body: ListView(
        children: [
          Center(
            child: Text('E-Mart',
                style: GoogleFonts.fugazOne(
                  textStyle: TextStyle(
                    fontSize: height * 0.1,
                    fontWeight: FontWeight.w100,
                    color: Colors.black,
                  ),
                )),
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
          SizedBox(
            height: height * 0.03,
          ),
          Center(
            child: Text(
              'About E-Mart',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: HexColor('#d91f2a'),
                  fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                "E-Mart is a one stop shop for all your fashion and lifestyle needs. Being India's largest e-commerce store for fashion and "
                "lifestyle products, E-Mart aims at providing a hassle free and enjoyable shopping experience to shoppers across the country"
                " with the widest range of brands and products on its portal.",
                textAlign: TextAlign.center,
                style: GoogleFonts.tangerine(
                  textStyle: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      wordSpacing: 2.0),
                )),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
              child: Text(
            'E-Mart MileStone',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          )),
          GridView(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              // padding: const EdgeInsets.fromLTRB(22.0, 10, 12, 10),
              //padding: const EdgeInsets.fromLTRB(6.0, 10, 22, 10),
              // padding: const EdgeInsets.fromLTRB(22.0, 4, 12, 10),
             // padding: const EdgeInsets.fromLTRB(6.0, 10, 22, 10),
              Card(
                color: Colors.black,
                child: ListTile(
                  title: FlatButton.icon(
                      onPressed: null,
                      icon: Icon(
                        Icons.people_outline,
                        color: Colors.white,
                      ),
                      label: Text("Users",
                          style: TextStyle(
                            color: Colors.green,
                          ))),
                  subtitle: Text(
                   '${userProvider.userlist.length}',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 60.0),
                  ),
                ),
              ),
              Card(
                color: Colors.black,
                child: ListTile(
                  title: FlatButton.icon(
                      onPressed: null,
                      icon: Icon(
                        Icons.category,
                        color: Colors.white,
                      ),
                      label: Text("Categories",
                          style: TextStyle(
                            color: Colors.green,
                          ))),
                  subtitle: Text('${categoryprovider.categorieslistp.length}',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 60.0),
                  ),
                ),
              ),
              Card(
                color: Colors.black,
                child: ListTile(
                  title: FlatButton.icon(
                      onPressed: null,
                      icon: Icon(
                        Icons.track_changes,
                        color: Colors.white,
                      ),
                      label: Text("Products",
                          style: TextStyle(
                            color: Colors.green,
                          ))),
                  subtitle: Text('${productprovider.productslist.length}',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 60.0),
                  ),
                ),
              ),
              Card(
                color: Colors.black,
                child: ListTile(
                  title: FlatButton.icon(
                      onPressed: null,
                      icon: Icon(
                        Icons.download_rounded,
                        color: Colors.white,
                      ),
                      label: Text("Downloads",
                          style: TextStyle(
                            color: Colors.green,
                          ))),
                  subtitle: Text(
                    '200',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 60.0),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Divider(
            thickness: 6,
            color: Colors.black,
          ),
          Center(
              child: Text(
            'Founder',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          )),
          SizedBox(
            height: 20,
          ),
          Container(
            child: CircleAvatar(
              radius: 100.0,
              child: ClipRRect(
                child: Image.asset(
                  'Assets/potdukhe1.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
              backgroundColor: Colors.transparent,
            ),
            decoration: new BoxDecoration(
              // border color
              shape: BoxShape.circle,
              border: Border.all(
                width: 8.0,
                color: HexColor('#6f6434'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
                child: Text('Sahil Potdukhe',
                    style: GoogleFonts.tangerine(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: HexColor('#d91f2a'),
                      ),
                    ))),
          ),
          Center(
              child: Text(
            'App Developer',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          )),
          Center(
              child: Text(
            'Student at IIIT Vadodara',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          )),
          SizedBox(
            height: 20,
          ),
          Divider(
            thickness: 6,
            color: Colors.black,
          ),
          Center(
              child: Text(
            'Core Values',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.deepPurple,
            ),
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                "While we adapt, evolve, and continue to grow, the beliefs that are most important to us stay the same - Audacity, Bias for Action, "
                "and Customer First - our core values which are reflected in everything we do! While these core values define"
                " our identity and form the basis of all our decisions and actions, integrity and inclusion underpins all our processes.",
                textAlign: TextAlign.center,
                style: GoogleFonts.stintUltraCondensed(
                  textStyle: TextStyle(
                    fontSize: 24,
                  ),
                )),
          ),
          SizedBox(height: 20,),
          Container(
            color: Colors.black87,
            height: 350,
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Contact Us',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: HexColor('#d91f2a'),
                      ),
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Image.network(
                          'https://i.pinimg.com/originals/b3/26/b5/b326b5f8d23cd1e0f18df4c9265416f7.png'),
                      iconSize: 50,
                      onPressed: () async {
                        const fburl =
                            'https://www.facebook.com/sahil.potdukhe.3/';
                        if (await canLaunch(fburl)) {
                          await launch(fburl);
                        } else {
                          throw 'Could not launch $fburl';
                        }
                      },
                    ),
                    IconButton(
                      icon: Image.asset('Assets/Instagram.png'),
                      onPressed: () async {
                        const instaurl =
                            'https://www.instagram.com/sahilpotdukhe11/';
                        if (await canLaunch(instaurl)) {
                          await launch(instaurl);
                        } else {
                          throw 'Could not launch $instaurl';
                        }
                      },
                    ),
                    IconButton(
                      icon: Image.asset('Assets/linkedin.png'),
                      onPressed: () async {
                        const linkedinurl =
                            'https://www.linkedin.com/in/sahil-potdukhe-317513198/';
                        if (await canLaunch(linkedinurl)) {
                          await launch(linkedinurl);
                        } else {
                          throw 'Could not launch $linkedinurl';
                        }
                      },
                      iconSize: 60,
                    ),
                    IconButton(
                      icon: Image.asset('Assets/twitter2.jpg'),
                      onPressed: () async {
                        const twitterurl =
                            'https://twitter.com/SahilPotdukhe';
                        if (await canLaunch(twitterurl)) {
                          await launch(twitterurl);
                        } else {
                          throw 'Could not launch $twitterurl';
                        }
                      },
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    IconButton(
                      icon: Icon(Icons.mail,color: Colors.white,),
                      onPressed: () async {
                        final Uri params=Uri(
                          scheme: 'mailto',
                          path: 'sahilpotdukhe.ssp@gmail.com',
                          query: 'subject=App Feedback'
                        );
                        var mailurl=params.toString();
                        if (await canLaunch(mailurl)) {
                          await launch(mailurl);
                        } else {
                          throw 'Could not launch $mailurl';
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.phone,color: Colors.white,),
                      onPressed: () async {
                        String telephoneUrl ='tel:7447332096';
                        if (await canLaunch(telephoneUrl)) {
                          await launch(telephoneUrl);
                        } else {
                          throw 'Could not launch $telephoneUrl';
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.location_on,color: Colors.white,),
                      onPressed: () async {
                       final String googlemapsurl ="https://www.google.com/maps/search/traffic+park/@21.1404273,79.057663,2751m/data=!3m1!1e3";
                        if (await canLaunch(googlemapsurl)) {
                          await launch(googlemapsurl);
                        } else {
                          throw 'Could not launch $googlemapsurl';
                        }
                      },
                    )
                  ],
                ),
                Divider(thickness: 2,color: Colors.white30,),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Corporate Address',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Children's Traffic Park, VIP Rd, Dharampeth, Nagpur, Maharashtra 440010",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: height*0.025,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Terms & Conditions  |   Privacy Policy',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
