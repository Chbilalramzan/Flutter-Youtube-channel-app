import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:happy_shouket/src/screens/home_screen.dart';
import 'package:happy_shouket/src/screens/phone_auth_screen.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  //Handles Auth
  handleAuth() {
    return StreamBuilder(
      stream: auth.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User user = snapshot.data;
          print(snapshot.data.uid);
          if (user == null) {
            return MobileAuthScreen();
          }
          return HomeScreen();
        }
        return Scaffold(
            body: Center(
          child: CircularProgressIndicator(),
        ));
      },
    );
  }

  //Sign out
  signOut() {
    auth.signOut();
  }

  signInWithOTP(String smsCode, String verId) {
    print(smsCode);
    final AuthCredential authCreds =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
    ;
    signIn(authCreds);
    print('Your uid is:' + verId);
  }

  //SignIn
  signIn(AuthCredential authCreds) {
    auth.signInWithCredential(authCreds);
    print('Your auth: ' + authCreds.toString());
  }
}
