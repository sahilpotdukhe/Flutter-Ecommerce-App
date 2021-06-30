import 'package:d_mart/Pages/Loading.dart';
import 'package:d_mart/provider/userprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  bool _isHidden = true;
 // bool isLoading = false;

  String email, password;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  void _togglepasswordview() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
  @override
  Widget build(BuildContext context) {
    final userprovider =Provider.of<UserProvider>(context);
    return Form(
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
                      controller: emailController,
                      decoration: InputDecoration(
                          hintText: 'Enter Your Email',
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            fontSize: 18.0,
                          ),
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.email)
                      ),
                      onChanged: (value) {
                        email = value;
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
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10,),
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
                            child: Icon(
                                _isHidden ? Icons.visibility_off : Icons.visibility),
                          )
                      ),
                      obscureText: _isHidden,
                      onChanged: (value) {
                        password = value;
                      },
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
                        child: userprovider.status==Status.Authenticating
                            ? Loading()
                            :
                        RaisedButton(
                          color: HexColor('#d91f2a'),
                          child: Text('Login',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                          onPressed: () async{
                            if (_formkey.currentState.validate()){
                              if(!await userprovider.signInme(emailController.text, passwordController.text))
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
                                          content: Text('       There is no user record \n corresponding to the identifier.'),
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
                            }
                        )
                    )
                  ],
                )
            )

        );
  }
}




// _formkey.currentState;
// setState(() {
//   isLoading = true;
// });
//}
// FirebaseAuth.instance.signInWithEmailAndPassword(
//     email: email, password: password)
//     .then((User) {
//   Navigator.pushReplacement(
//       context, MaterialPageRoute(builder: (context) =>
//       HomePage()));
// })
//     .catchError((e) {
//   print(e.message);
//   setState(() {
//     isLoading = false;
//   });

// });