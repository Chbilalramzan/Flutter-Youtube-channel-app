import 'package:flutter/material.dart';
import 'package:happy_shouket/src/localization/localization_constant.dart';
import 'package:happy_shouket/src/models/videos_list.dart';
import 'package:happy_shouket/src/netwk/youtube.dart';
import 'package:happy_shouket/src/screens/intervention_rating.dart';
import 'package:happy_shouket/src/widgets/session_videos_list.dart';
import 'package:happy_shouket/src/widgets/video_scaffold.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class SessionThreePsycho extends StatefulWidget {
  static const String routeName = 'session3_psycho_screen';

  @override
  _SessionThreePsychoState createState() => _SessionThreePsychoState();
}

class _SessionThreePsychoState extends State<SessionThreePsycho> {
  // TargetPlatform _platform;
  VideoPlayerController _videoPlayerController1;
  ChewieController _chewieController;

  // @override
  // void initState() {
  //   super.initState();

  //   _videoPlayerController1 =
  //       VideoPlayerController.asset('assets/session3/Dialysis.mp4');

  //   _chewieController = ChewieController(
  //       videoPlayerController: _videoPlayerController1,
  //       aspectRatio: 3 / 2,
  //       autoPlay: true,
  //       looping: true,
  //       showControls: true,
  //       materialProgressColors: ChewieProgressColors(
  //         playedColor: Colors.red,
  //         handleColor: Colors.blue,
  //         backgroundColor: Colors.grey,
  //         bufferedColor: Colors.lightGreenAccent,
  //       ),
  //       placeholder: Container(
  //         color: Colors.orangeAccent,
  //       ),
  //       autoInitialize: true,
  //       errorBuilder: (context, errorMessage) {
  //         return Center(
  //           child: Text(
  //             errorMessage,
  //             style: TextStyle(color: Colors.white),
  //           ),
  //         );
  //       },
  //       routePageBuilder: (BuildContext context, Animation<double> animation,
  //           Animation<double> secondAnimation, provider) {
  //         return AnimatedBuilder(
  //           animation: animation,
  //           builder: (BuildContext context, Widget child) {
  //             return VideoScaffold(
  //               child: Scaffold(
  //                 resizeToAvoidBottomInset: false,
  //                 body: Container(
  //                   alignment: Alignment.center,
  //                   color: Colors.black,
  //                   child: provider,
  //                 ),
  //               ),
  //             );
  //           },
  //         );
  //       });
  // }

  VideosList _videosList;
  bool _loading;
  PageInfo _pageInfo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loading = true;
    _pageInfo = PageInfo(totalResults: 0, resultsPerPage: 0);
    _videosList = VideosList(
        etag: '', kind: '', nextPageToken: '', pageInfo: _pageInfo, videos: []);
    _videosList.videos = [];
    _loadVideos();
  }

  _loadVideos() async {
    VideosList tempVideosList = await Services.getVideosList();
    for (var item in tempVideosList.videos) {
      if (item.video.title.contains('psychoeducation') &&
          item.video.title.contains('Session 3')) {
        _videosList.videos.add(item);
      }
    }
    setState(() {
      _loading = false;
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
    return Scaffold(
        appBar: AppBar(
          title: Text(getTranslated(context, "psycho_med") +
              " " +
              getTranslated(context, "session3")),
          actions: [
            TextButton(
              onPressed: () =>
                  //sign out
                  Navigator.pushNamed(context, EduRatingScreen.routeName),
              child: Text(
                getTranslated(context, "next_button"),
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        body: _loading
            ? Center(child: CircularProgressIndicator())
            : SessionVideosList(videosList: _videosList)

        //  Column(
        //   children: <Widget>[
        //     Expanded(
        //       child: Center(
        //         child: Chewie(
        //           controller: _chewieController,
        //         ),
        //       ),
        //     ),
        //     TextButton(
        //       onPressed: () {
        //         _chewieController.enterFullScreen();
        //       },
        //       child: Text(
        //         'Fullscreen',
        //         style: TextStyle(fontSize: 20.0),
        //       ),
        //     ),
        //     Row(
        //       children: <Widget>[
        //         Expanded(
        //           child: TextButton(
        //             onPressed: () {
        //               setState(() {
        //                 _chewieController.dispose();
        //                 _chewieController = ChewieController(
        //                   videoPlayerController: _videoPlayerController1,
        //                   aspectRatio: 3 / 2,
        //                   autoPlay: true,
        //                 );
        //               });
        //             },
        //             child: Padding(
        //               child: Text("Video 1"),
        //               padding: EdgeInsets.symmetric(vertical: 16.0),
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ],
        // ),

        );
  }
}
