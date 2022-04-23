import 'dart:async' show Future;
import 'package:flutter/material.dart';
import 'package:project/login/Home.dart';
import 'package:project/login/Login.dart';
import 'package:project/login/SignUp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future checkFun() async{
    final pref = await SharedPreferences.getInstance();
    String? email = pref.getString("email");
    String? userEmail=pref.getString("userEmail");
    if(email == userEmail && pref.getString("password") == pref.getString("userPassword")){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Home()));
    }
    else if(pref.containsKey("userEmail"))
    {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Login()));
    }
    else
      {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignUp()));
      }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3),(){checkFun();});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
          color: Colors.white,
          // child: Image.asset(
          //   'assets/images/4.jpg',
          //   fit: BoxFit.cover,
          //   height: double.infinity,
          //   width: double.infinity,
          //   alignment: Alignment.center,
          // )
          child: FlutterLogo(size:MediaQuery.of(context).size.height)
          ),
    );
  }

}
