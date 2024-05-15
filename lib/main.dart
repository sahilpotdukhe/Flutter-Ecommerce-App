import 'package:d_mart/Pages/SplashScreen.dart';
import 'package:d_mart/Pages/StartPage.dart';
import 'package:d_mart/provider/CategoryProvider.dart';
import 'package:d_mart/provider/appProvider.dart';
import 'package:d_mart/provider/productProvider.dart';
import 'package:d_mart/provider/userprovider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider.value(value:UserProvider.initialize()),
      ChangeNotifierProvider.value(value:ProductProvider.initialize()),
      ChangeNotifierProvider.value(value:CategoryProvider.initialize()),
      ChangeNotifierProvider.value(value: AppProvider()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScreenController(),
    ),
    );
  }
}
class ScreenController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user =Provider.of<UserProvider>(context);
    switch(user.status){
      case Status.Uninitialized:
        return SplashScreen();
      case Status.Unauthenticated:
        return StartPage();
      case Status.Authenticating:
        return StartPage();
      case Status.Authenticated:
        return SplashScreen();
      default:return StartPage();
    }
  }
}

