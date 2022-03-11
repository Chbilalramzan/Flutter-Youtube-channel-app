import 'package:flutter/material.dart';
import 'package:happy_shouket/src/models/videos_list.dart';
import 'package:happy_shouket/src/netwk/youtube.dart';
import 'package:happy_shouket/src/screens/intervention_rating.dart';
import 'package:happy_shouket/src/sessions_collection/session_two/sessions_two_screen.dart';
import 'package:happy_shouket/src/widgets/session_videos_list.dart';
import 'package:happy_shouket/src/widgets/video_scaffold.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class SessionTwoSpiritual extends StatefulWidget {
  static const String routeName = 'session2_spiritual_screen';

  @override
  _SessionTwoSpiritualState createState() => _SessionTwoSpiritualState();
}

class _SessionTwoSpiritualState extends State<SessionTwoSpiritual> {
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
      if (item.video.title.contains('spirituality') &&
          item.video.title.contains('Session 2')) {
        _videosList.videos.add(item);
      }
    }
    setState(() {
      _loading = false;
    });
  }

  TargetPlatform _platform;
  VideoPlayerController _videoPlayerController1;
  VideoPlayerController _videoPlayerController2;

  ChewieController _chewieController;

  // @override
  // void initState() {
  //   super.initState();
  //   _videoPlayerController1 =
  //       VideoPlayerController.asset('assets/session2/Asma.mkv');
  //   _videoPlayerController2 =
  //       VideoPlayerController.asset('assets/session2/Surah.mp4');

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
  //             style: TextStyle(color: Colors.black87),
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

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _videoPlayerController2.dispose();

    _chewieController.dispose();
    _videosList.videos.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SESSION TWO SPIRITUAL PSYCHOLOGICAL'),
          actions: [
            // ignore: deprecated_member_use
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
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacementNamed(
                  context, SessionTwoScreen.routeName);
            },
          ),
        ),
        body: _loading
            ? Center(child: CircularProgressIndicator())
            : SessionVideosList(videosList: _videosList)

        // Column(
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
        //                 _videoPlayerController2.pause();
        //                 _videoPlayerController2.seekTo(Duration(seconds: 0));
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
        //         Expanded(
        //           child: TextButton(
        //             onPressed: () {
        //               setState(() {
        //                 _chewieController.dispose();
        //                 _chewieController = ChewieController(
        //                   videoPlayerController: _videoPlayerController2,
        //                   aspectRatio: 3 / 2,
        //                   looping: true,
        //                   autoPlay: true,
        //                 );
        //               });
        //             },
        //             child: Padding(
        //               padding: EdgeInsets.symmetric(vertical: 16.0),
        //               child: Text("Video 2"),
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
