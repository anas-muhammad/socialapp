import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';



final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
String name;
String email;
String photoURL;

Future<String> signInWithGoogle() async {
  
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential authResult = await _auth.signInWithCredential(credential);
  print(authResult);
  final User user = authResult.user;
  print(user);

assert(user.email != null);
assert(user.displayName != null);
assert(user.photoURL != null);
name = user.displayName;
email = user.email;
photoURL = user.photoURL;
  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final User currentUser =_auth.currentUser;
  assert(user.uid == currentUser.uid);

  return 'signInWithGoogle succeeded: $user';
}

void signOutGoogle(context) async{
  await googleSignIn.signOut();
  Navigator.pop(context);
  print("User Sign Out");
}





