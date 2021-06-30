import 'package:d_mart/Pages/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

class GoogleLogin extends StatefulWidget {
  @override
  _GoogleLoginState createState() => _GoogleLoginState();
}

class _GoogleLoginState extends State<GoogleLogin> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  SharedPreferences preferences;
  bool loading = false;
  bool isloggedin = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSignedIn();
  }

  void isSignedIn() async {
    setState(() {
      loading = true;
    });
    preferences = await SharedPreferences.getInstance();
    isloggedin = await googleSignIn.isSignedIn();
    if (isloggedin) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
    setState(() {
      loading = false;
    });
  }

  Future<Null> handleSignIn() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      loading = true;
    });
    GoogleSignInAccount googleuser = await googleSignIn.signIn();

    GoogleSignInAuthentication googleSignInAuthentication = await googleuser.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    //UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    User user = (await firebaseAuth.signInWithCredential(credential)).user;

    if (user != null) {
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: user.uid)
          .get();
      List<DocumentSnapshot> documents = result.docs;
      if (documents.length == 0) {
        //insert the user to the collection
        FirebaseFirestore.instance.collection('users')
            .doc(user.uid)
            .set(
            {
              'id':user.uid,
              'username':user.displayName,
              'profilePicture':user.photoURL
            });
        await preferences.setString('id',user.uid);
        await preferences.setString('username', user.displayName);
        await preferences.setString('photoUrl', user.photoURL);
      }else{
        await preferences.setString('id', documents[0].data()['id']);
        await preferences.setString('username', documents[0].data()['username']);
        await preferences.setString('photoUrl', documents[0].data()['photoUrl']);
      }
      Fluttertoast.showToast(msg: 'Login was successful');
      setState(() {
        loading=false;
      });
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
    }else{
      Fluttertoast.showToast(msg: "Login Failed");
      setState(() {
        loading=false;
      });
    }
  }
  // void signOutGoogle() async {
  //   await googleSignIn.signOut();
  //   print('User Signed Out');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Login'),
      ),
      body: Stack(
        children: [
          Center(
            child: SignInButton(
              Buttons.GoogleDark,
              onPressed: (){
                handleSignIn();
              },
            ),
          ),
          Visibility(
            visible: loading??true,
            child: Center(
              child: Container(
                color: Colors.white.withOpacity(0.8),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),
            ),
          )
        ],

      ),
    );
  }
}
