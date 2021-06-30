import 'package:d_mart/Pages/Homepage.dart';
import 'package:d_mart/Pages/LoginForm.dart';
import 'package:d_mart/Pages/SignUpForm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:hexcolor/hexcolor.dart';
class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final FirebaseAuth firebaseAuth =FirebaseAuth.instance;
  bool formVisible=false;
  int _formIndex=1;
  // bool isLoggedIn=false;
  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   isSignedIn();
  // }
  // void isSignedIn() async{
  //   User user = await firebaseAuth.currentUser;
  //   if(user != null){
  //     setState(() => isLoggedIn = true);
  //   }
  //   if (isLoggedIn) {
  //     Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (context) => HomePage()));
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(
          children: [
            Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image:AssetImage('Assets/start1.jpg'),
                  fit: BoxFit.fill,
                )
            ),
        ),
            Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: height*0.6,),
                    // Text(
                    //   'Welcome To India\'s Shopping',
                    //   style: GoogleFonts.badScript(
                    //     textStyle :TextStyle(
                    //     color:  HexColor('#d91f2a'),
                    //     fontSize: 28.0,
                    //     fontWeight: FontWeight.w900,
                    //     backgroundColor: Colors.black,
                    //   ),
                    //   ),
                    //   textAlign: TextAlign.center,
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 6.0),
                    //   child: Text(
                    //     'Platform',
                    //     style: GoogleFonts.badScript(
                    //       textStyle :TextStyle(
                    //         color:  HexColor('#d91f2a'),
                    //         fontSize: 28.0,
                    //         fontWeight: FontWeight.w900,
                    //         backgroundColor: Colors.black,
                    //       ),
                    //     ),
                    //     textAlign: TextAlign.center,
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: height*0.281,
                    // ),
                    Row(
                      children: [
                        SizedBox(width: width*0.05,),
                        Expanded(
                          child: RaisedButton(
                              color: HexColor('#d91f2a'),
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)
                              ),
                              child: Text('Login',
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  formVisible=true;
                                  _formIndex=1;
                                });
                              }
                          ),
                        ),
                        SizedBox(width: width*0.05,),
                        Expanded(
                          child: RaisedButton(
                              color: Colors.green[800],
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)
                              ),
                              child: Text('Signup',
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  formVisible=true;
                                  _formIndex=2;
                                });
                              }
                          ),
                        ),
                        SizedBox(width: width*0.05,),
                      ],
                    ),
                    SizedBox(height: height*0.02,),
                    Container(
                      child: SignInButton(
                        Buttons.GoogleDark,
                        onPressed: (){},
                      ),
                    ),
                    //SizedBox(height: height*0.2048,),
                    // Container(
                    //   decoration: BoxDecoration(
                    //       color: HexColor('#d91f2a'),
                    //       borderRadius: BorderRadius.only(
                    //         topLeft: Radius.circular(50.0),
                    //         topRight: Radius.circular(50.0),
                    //       )
                    //   ),
                    //   child: Image.asset('Assets/logo3.png'),
                    //
                    // ),
                  ],
                ),
              ),
            ),
            AnimatedSwitcher(
              //It is for loading the the login ,signup and close button along with login or signup
              // form when user clicked on login or signup button from the second children of stack
                duration: Duration(milliseconds: 200),
                child: (formVisible)//for animated switching of either a container or null(nothing)
                    ?Container(
                  color: Colors.black54,
                  alignment: Alignment.center,
                   child: Column(
                    mainAxisSize: MainAxisSize.min,//these gives the size of the column only the required size of the widget in the column
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton(
                              textColor: _formIndex==1?Colors.white:Colors.black,
                              color: _formIndex==1? HexColor('#d91f2a'): Colors.white,
                              child: Text('Login'),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              onPressed:(){
                                setState(() {
                                  _formIndex=1;
                                });
                              }
                          ),
                          SizedBox(width: 10.0,),
                          RaisedButton(
                              textColor: _formIndex==2?Colors.white:Colors.black,
                              color: _formIndex==2? HexColor('#d91f2a'): Colors.white,
                              child: Text('SignUp'),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              onPressed:(){
                                setState(() {
                                  _formIndex=2;
                                });
                              }),
                          SizedBox(width: 10.0,),
                          IconButton(
                              color:Colors.white,
                              icon: Icon(Icons.clear),
                              onPressed: (){
                                setState(() {
                                  formVisible=false;
                                });
                              }),
                        ],
                      ),
                      Container(
                        child: AnimatedSwitcher(//for animated switching of either a loginform or signup form
                          duration: Duration(milliseconds: 200),
                          child: _formIndex==1 ? LoginForm():SignupForm(),
                        ),
                      )
                    ],
                  ),
                )
                    :null
            ),
          ]
        )
    );
  }
}
