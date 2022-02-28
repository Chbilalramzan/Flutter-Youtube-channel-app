// @dart=2.9

import 'package:flutter/material.dart';
import 'package:happy_shouket/src/screens/intervention_rating.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:happy_shouket/src/screens/video_items.dart';

class SessionOnePosItems extends StatelessWidget {
  static const String routeName = 'session1_positive_screen';

  @override
  Widget build(BuildContext context) {
    ChewieController _chewieController;
    return Scaffold(
      appBar: AppBar(
        title: Text('POSITIVE PSYCHOLOGY SESSION ONE'),
        actions: [
          TextButton(
            onPressed: () =>
            //sign out
            Navigator.pushNamed(context, EduRatingScreen.routeName),
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
      body: ListView(
        children: <Widget>[
          VideoItems(
            videoPlayerController: VideoPlayerController.asset(
                'assets/session1/rumi_1.mp4'),
            looping: true,
            autoplay: true,
          ),
          VideoItems(
            videoPlayerController: VideoPlayerController.asset(
                'assets/session1/amir_3.mp4'),
            looping: true,
            autoplay: true,
          ),
          VideoItems(
            videoPlayerController: VideoPlayerController.asset(
                'assets/session1/amir_3.mp4'),
            looping: true,
            autoplay: true,
          ),
          TextButton(
            onPressed: () {
              _chewieController.enterFullScreen();
            },
            child: Text(
              'Fullscreen',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ],
      ),
    );
  }
}