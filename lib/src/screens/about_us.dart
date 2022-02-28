import 'package:flutter/material.dart';
import 'package:happy_shouket/src/widgets/home_drawer.dart';

class AboutUsScreen extends StatefulWidget {
  static const String routeName = 'about_us_screen';

  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
        child: Text('What We do'),
      ),
    );
  }
}
