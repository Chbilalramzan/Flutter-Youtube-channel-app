import 'package:flutter/material.dart';
import 'package:happy_shouket/src/screens/intervention_rating.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:happy_shouket/src/screens/video_items.dart';

class SessionEightPsychoedu extends StatelessWidget {
  static const String routeName = 'session8_psychoedu_screen';

  @override
  Widget build(BuildContext context) {
    ChewieController _chewieController;
    return Scaffold(
      appBar: AppBar(
        title: Text('PSYCHO-EDUCATION SESSION EIGHT'),
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
                'assets/session8/dialysis_exercises.mp4'),
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
