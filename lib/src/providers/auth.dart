import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:happy_shouket/src/screens/home_screen.dart';
import 'package:happy_shouket/src/screens/tabs_screen.dart';

abstract class AuthBase {
  User get currentUser;

  Stream<User> authStateChanges();

  Future<User> signup(String email, String password);

  Future<User> login(String email, String password);

  Future<void> signInWithOTP(
      String smsCode, String verId, BuildContext context);

  Future<void> signIn(AuthCredential authCreds);

  Future<void> signOut();
}

class Auth implements AuthBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool get isAuth {
    return currentUser != null;
  }

  @override
  Stream<User> authStateChanges() => _firebaseAuth.authStateChanges();

  @override
  User get currentUser => _firebaseAuth.currentUser;

  @override
  Future<User> login(String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithCredential(
      EmailAuthProvider.credential(email: email, password: password),
    );
    return userCredential.user;
  }

  @override
  Future<User> signup(String email, String password) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  @override
  Future<void> signInWithOTP(
      String smsCode, String verId, BuildContext context) async {
    print(smsCode);
    print(verId);
    final AuthCredential authCreds =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
    // BuildContext context;

    Navigator.pushReplacementNamed(context, TabsScreen.routeName);
    signIn(authCreds);
  }

  @override
  Future<void> signIn(AuthCredential authCreds) async {
    _firebaseAuth.signInWithCredential(authCreds);
    return HomeScreen();
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}

// class Auth with ChangeNotifier {
//   String _token;
//   DateTime _expiryDate;
//   String _userId;
//   Timer _authTimer;
//
//   bool get isAuth {
//     return token != null;
//   }
//
//   String get token {
//     if (_expiryDate != null &&
//         _expiryDate.isAfter(DateTime.now()) &&
//         _token != null) {
//       return _token;
//     }
//     return null;
//   }
//
//   String get userId {
//     return _userId;
//   }
//
//   Future<void> _authenticate(
//       String email, String password, String urlSegment) async {
//     final url = Uri.parse(
//         'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyBPe0EhOPRWFCgzZ6gnKgL6eUG79iaY56g');
//     try {
//       final response = await http.post(
//         url,
//         body: json.encode(
//           {
//             'email': email,
//             'password': password,
//             'returnSecureToken': true,
//           },
//         ),
//       );
//       print(json.decode(response.body));
//       final responseData = json.decode(response.body);
//       if (responseData['error'] != null) {
//         throw HttpException(responseData['error']['message']);
//       }
//       _token = responseData['idToken'];
//       _userId = responseData['localId'];
//       _expiryDate = DateTime.now().add(
//         Duration(
//           seconds: int.parse(
//             responseData['expiresIn'],
//           ),
//         ),
//       );
//       _autoLogout();
//       notifyListeners();
//       final prefs = await SharedPreferences.getInstance();
//       final userData = json.encode(
//         {
//           'token': _token,
//           'userId': _userId,
//           'expiryDate': _expiryDate.toIso8601String()
//         },
//       );
//       prefs.setString('userData', userData);
//     } catch (error) {
//       throw error;
//     }
//   }
//
//   Future<void> signup(String email, String password) async {
//     return _authenticate(email, password, 'signup');
//   }
//
//   Future<void> login(String email, String password) async {
//     return _authenticate(email, password, 'signInWithPassword');
//   }
//
//   Future<bool> tryAutoLogin() async {
//     final prefs = await SharedPreferences.getInstance();
//     if (!prefs.containsKey('userData')) {
//       return false;
//     }
//     final extractedUserData =
//         json.decode(prefs.getString('userData')) as Map<String, Object>;
//     final expiryDate = DateTime.parse(extractedUserData['expiryDate']);
//
//     if (expiryDate.isAfter(DateTime.now())) {
//       return false;
//     }
//     _token = extractedUserData['token'];
//     _userId = extractedUserData['userId'];
//     _expiryDate = expiryDate;
//     notifyListeners();
//     _autoLogout();
//     return true;
//   }
//
//   Future<void> logout() async {
//     _token = null;
//     _userId = null;
//     _expiryDate = null;
//     if (_authTimer != null) {
//       _authTimer.cancel();
//       _authTimer = null;
//     }
//     notifyListeners();
//     final prefs = await SharedPreferences.getInstance();
//     prefs.remove('userData');
//
//     // //only used when only storing user data
//     // prefs.clear();
//   }
//
//   // Future<void> _signOut() async {
//   //   try {
//   //     await FirebaseAuth.instance.signOut();
//   //   } catch (e)
//   //   {
//   //     print(e.toString());
//   //   }
//   // }
//
//   void _autoLogout() {
//     if (_authTimer != null) {
//       _authTimer.cancel();
//     }
//     final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
//     _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
//   }
// }
