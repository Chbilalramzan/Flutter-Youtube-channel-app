import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:happy_shouket/src/providers/auth.dart';
import 'package:happy_shouket/src/providers/database.dart';
import 'package:happy_shouket/src/screens/home_screen.dart';
import 'package:happy_shouket/src/screens/login_screen.dart';
import 'package:happy_shouket/src/screens/phone_auth_screen.dart';
import 'package:happy_shouket/src/screens/tabs_screen.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  static const String routeName = 'landing_page';

  const LandingPage({Key key, @required this.databaseBuilder})
      : super(key: key);
  final Database Function(String) databaseBuilder;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<User>(
      stream: auth.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User user = snapshot.data;
          // print(snapshot.data.uid);
          if (user == null) {
            return LoginScreen();
          }
          return Provider<Database>(
            create: (_) => databaseBuilder(user.uid),
            child: TabsScreen(),
          );
        }
        return Scaffold(
            body: Center(
          child: CircularProgressIndicator(),
        ));
      },
    );
  }
}
