import 'dart:io';


import 'package:appsnadologin/second_screen.dart';
import 'package:appsnadologin/sign_in.dart';
import 'package:flutter/material.dart';

import 'first_screen.dart';
import 'contsants/constants.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}





class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings.APP_TITLE,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Login(title:Strings.LOGIN_SCREEN_TITLE),
    );
  }
}

class Login extends StatefulWidget {
  Login({Key key, this.title}) : super(key: key);

  final String title;



  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      appBar: AppBar(
      
        title: Text(widget.title),
      ),
      body:Container(
          padding: EdgeInsets.only(top:200),
          child: Center(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
             child: _signInGoogle(),
        ),
        SizedBox(height: 20,),
        Container(child: _signInFacebook()),
         SizedBox(height: 20,),
         Platform.isIOS
            ? Container(child: 
                 _signInApple() )
                 : Container(),
             
    
      ],
            ),
          ),
      ),
   
    );
  }


  Widget _signInGoogle() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        signInWithGoogle().whenComplete(() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return FirstScreen();
          },
        ),
      );
    });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
              Strings.GOOGLE_BUTTON,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }



  Widget _signInFacebook() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
    
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return SecondScreen();
          },
        ),
    );
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/facebook_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
              Strings.FACEBOOK_BUTTON,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  Widget _signInApple() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
    
    //   Navigator.of(context).push(
    //     MaterialPageRoute(
    //       builder: (context) {
    //      //   return ThirdScreen();
    //       },
    //     ),
    // );
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/apple_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
              Strings.APPLE_BUTTON,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }







}
