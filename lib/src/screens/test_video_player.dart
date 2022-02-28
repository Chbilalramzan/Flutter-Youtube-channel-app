import 'package:flutter/material.dart';
import 'package:happy_shouket/src/screens/feedback_screen.dart';
import 'package:video_player/video_player.dart';
import '../widgets/test_video_items.dart';

class TestVideoScreen extends StatelessWidget {
  static const String routeName = 'test_video_player';
  final String authToken;

  const TestVideoScreen({Key key, this.authToken}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Positive Psycho Demo Video Player '),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          // VideoItems(
          //   videoPlayerController: VideoPlayerController.asset(
          //     'assets/video_6.mp4',
          //   ),
          //   looping: true,
          //   autoplay: true,
          // ),
          // VideoItems(
          //   videoPlayerController: VideoPlayerController.network(
          //       'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4'),
          //   looping: false,
          //   autoplay: true,
          // ),
          VideoItems(
            videoPlayerController:
                VideoPlayerController.asset('assets/positive/rumi_final.mp4'),
            autoplay: true,
          ),
          VideoItems(
            videoPlayerController: VideoPlayerController.asset(
              'assets/positive/resource_hymodylisis.mp4',
            ),
            looping: true,
            autoplay: false,
          ),
          VideoItems(
            videoPlayerController: VideoPlayerController.asset(
              'assets/positive/amir.mp4',
            ),
            looping: false,
            autoplay: false,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, FeedbackScreen.routeName);
        },
        child: Icon(Icons.navigate_next_sharp),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
