import 'dart:convert';
import 'dart:io';

import 'package:appsnadologin/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;

import 'contsants/constants.dart';
import 'first_screen.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  bool isLoggedIn = false;
  var profileData;

  var facebookLogin = FacebookLogin();

  void onLoginStatusChanged(bool isLoggedIn, {profileData}) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
      this.profileData = profileData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Demo"),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              onPressed: () => facebookLogin.isLoggedIn
                  .then((isLoggedIn) => isLoggedIn ? _logout() : {}),
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.only(top: 150),
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  child: isLoggedIn
                      ? _displayUserData(profileData)
                      : _signInFacebook(),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: _signInGoogle(),
                ),
                SizedBox(
                  height: 20,
                ),
                Platform.isIOS ? Container(child: _signInApple()) : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void initiateFacebookLogin() async {
    var facebookLoginResult = await facebookLogin.logIn(['email']);

    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.cancelledByUser:
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.loggedIn:
        var graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=${facebookLoginResult.accessToken.token}');

        var profile = json.decode(graphResponse.body);
        print(profile.toString());

        onLoginStatusChanged(true, profileData: profile);
        break;
    }
  }

  _displayUserData(profileData) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 200.0,
          width: 200.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                profileData['picture']['data']['url'],
              ),
            ),
          ),
        ),
        SizedBox(height: 28.0),
        Text(
          "Logged in as: ${profileData['name']}",
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
      ],
    );
  }

  _displayLoginButton() {
    return RaisedButton(
      child: Text("Login with Facebook"),
      onPressed: () => initiateFacebookLogin(),
    );
  }

  _logout() async {
    await facebookLogin.logOut();
    onLoginStatusChanged(false);
    print("Logged out");
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
        initiateFacebookLogin();
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
        //       //  return ThirdScreen();
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
