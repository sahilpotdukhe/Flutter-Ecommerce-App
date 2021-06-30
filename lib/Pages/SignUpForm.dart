import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_mart/Pages/Homepage.dart';
import 'package:d_mart/Pages/Loading.dart';
import 'package:d_mart/provider/userprovider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  String displayName,email,password;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isHidden=true;
  //bool isLoading=false;
  //final _key = GlobalKey<ScaffoldState>();

  final _formkey = GlobalKey<FormState>();//Use to validate

  void _togglepasswordview(){
    setState(() {
      _isHidden =! _isHidden;
    });
  }
  @override
  Widget build(BuildContext context) {
    final userprovider = Provider.of<UserProvider>(context);
    return  Form(
          key: _formkey,
          child:Container(
            margin: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: ListView(
              padding: EdgeInsets.all(16.0),
              shrinkWrap: true,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Name',
                    labelText: 'Name',
                    labelStyle: TextStyle(
                        fontSize: 18.0
                    ),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value){
                    displayName=value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter Name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10.0,),
                TextFormField(
                  controller:emailController,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Email',
                    labelText: 'Email',
                    labelStyle: TextStyle(
                        fontSize: 18.0
                    ),
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.email),
                  ),
                  onChanged: (value){
                    email=value;
                  },
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter email address';
                    }
                    if (!RegExp(
                        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?"
                        r"(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                        .hasMatch(value)) {
                      return 'Please enter a valid email Address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10.0,),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                      hintText: 'Enter Password',
                      labelText: 'Password',
                      labelStyle: TextStyle(
                          fontSize: 18.0
                      ),
                      border: OutlineInputBorder(),
                      suffix: InkWell(
                        onTap: _togglepasswordview,
                        child: Icon(_isHidden ? Icons.visibility_off : Icons.visibility),
                      )
                  ),
                  onChanged: (value){
                    password=value;
                  },
                  obscureText: _isHidden,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter the Password';
                    }
                    else if (value.length < 6) {
                      return 'Enter password more than 6 characters';
                    }
                    return null;
                  },
                ),
                Center(
                    child: userprovider.status==Status.Authenticating?
                        Loading()
                        :
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: RaisedButton(
                        color: HexColor('#d91f2a'),
                        child: Text('Signup',
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                        onPressed: () async{
                          if(_formkey.currentState.validate()){
                            if(!await userprovider.signUpme(nameController.text, emailController.text, passwordController.text))
                            {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context){
                                    return AlertDialog(
                                        title: Center(
                                          child:Text('Error',
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 22.0,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ) ,
                                        ),
                                        content: Text('     The email address is already \n      in use by another account.'),
                                        actions: [
                                          FlatButton(
                                              child: Text('Retry'),
                                              onPressed:(){
                                                // setState(() {
                                                //   isLoading=false;
                                                //   // dispose();
                                                // });
                                                Navigator.pop(context,true);
                                              }
                                          )
                                        ]
                                    );
                                  }
                              );
                            }
                          }
                        },
                      ),
                    )
                )
              ],
            ),
          )

        );
  }
}
// FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)
// .then((signedInUser){
//   FirebaseFirestore.instance.collection('eusers')
//       .add({
//           'displayname':nameController.text,
//           'email':emailController.text,
//           'password':passwordController.text,
//   })
//       .then((value){
//         if(signedInUser!=null){
//           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()));
//         }
//   })
//       .catchError((e){
//         print(e);
//   });
// })
// .catchError((e){
//   print(e);
// }
// );