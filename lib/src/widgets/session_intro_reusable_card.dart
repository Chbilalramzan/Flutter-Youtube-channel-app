import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:happy_shouket/src/constants/urls.dart';
import 'package:happy_shouket/src/widgets/video_scaffold.dart';
import 'package:video_player/video_player.dart';

class IntroReusableCard extends StatefulWidget {
  // IntroReusableCard({@required this.colour, this.cardChild, this.onPress});  // const ReusableCard({Key key,}) : super(key: key);

  const IntroReusableCard({Key key}) : super(key: key);
  @override
  _IntroReusableCardState createState() => _IntroReusableCardState();
}

class _IntroReusableCardState extends State<IntroReusableCard> {
  TargetPlatform _platform;
  VideoPlayerController _videoPlayerController1;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController1 =
        VideoPlayerController.network(Url.Session_Intro_Video);

    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController1,
        aspectRatio: 3 / 2,
        autoPlay: true,
        looping: true,
        showControls: true,
        materialProgressColors: ChewieProgressColors(
          playedColor: Colors.red,
          handleColor: Colors.blue,
          backgroundColor: Colors.grey,
          bufferedColor: Colors.lightGreenAccent,
        ),
        placeholder: Align(
          alignment: Alignment.center,
          child: Container(
            // color: Colors.orangeAccent,
            child: CachedNetworkImage(
                width: 500,
                height: 500,
                fit: BoxFit.contain,
                imageUrl: Url.Thumbnail_Session_Intro_Video),
          ),
        ),
        autoInitialize: true,
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              errorMessage,
              style: TextStyle(color: Colors.white),
            ),
          );
        },
        routePageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondAnimation, provider) {
          return AnimatedBuilder(
            animation: animation,
            builder: (BuildContext context, Widget child) {
              return VideoScaffold(
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: Container(
                    alignment: Alignment.center,
                    color: Colors.black,
                    child: provider,
                  ),
                ),
              );
            },
          );
        });
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Center(
            child: Chewie(
              controller: _chewieController,
            ),
          ),
        ),
        FlatButton(
          onPressed: () {
            _chewieController.enterFullScreen();
          },
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    _chewieController.dispose();
                    ;
                    _chewieController = ChewieController(
                      videoPlayerController: _videoPlayerController1,
                      aspectRatio: 3 / 2,
                      autoPlay: false,
                    );
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
