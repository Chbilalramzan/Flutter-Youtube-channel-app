import 'package:flutter/material.dart';
import 'package:happy_shouket/src/constants/urls.dart';
import 'package:happy_shouket/src/localization/localization_constant.dart';
import 'package:happy_shouket/src/screens/tabs_screen.dart';
import 'package:happy_shouket/src/screens/video_items.dart';
import 'package:happy_shouket/src/widgets/home_drawer.dart';
import 'package:happy_shouket/src/widgets/responsive_ui.dart';

import 'package:video_player/video_player.dart';

double _height;
double _width;
double _pixelRatio;
bool _large;
bool _medium;

class HomeScreen extends StatelessWidget {
  static const String routeName = 'home_screen';

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    return Scaffold(
      backgroundColor: Colors.orange[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Happy Shouket Home',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            )),
        // centerTitle: true,
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pushNamed(context, TabsScreen.routeName),
            child: Text(
              'Next',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                  left: _width / 60, top: _height / 20, bottom: 10.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text(
                      getTranslated(context, 'welcome_note'),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: _large ? 25 : (_medium ? 50 : 40),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Card(
                  child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                        left: _width / 60, top: _height / 20, bottom: 0.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Text(
                            "We’re so happy you’re here! The concept is simple: Happy Shouket helps you get motivated, and get more understanding on how to manage ESRD (with your community or on your own)",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: _large ? 25 : (_medium ? 50 : 40),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // NextButton,
                ],
              )),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: _width / 60, top: _height / 20, bottom: 10.0),
              child: Column(
                children: <Widget>[
                  VideoItems(
                    videoPlayerController:
                        VideoPlayerController.network(Url.Intro_Video),
                    looping: true,
                    autoplay: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
