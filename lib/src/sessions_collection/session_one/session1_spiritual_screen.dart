import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:happy_shouket/src/models/videos_list.dart';
import 'package:happy_shouket/src/netwk/youtube.dart';
import 'package:happy_shouket/src/screens/intervention_rating.dart';
import 'package:happy_shouket/src/screens/youtube_player_view.dart';
import 'main_menu.dart';
import 'package:happy_shouket/src/widgets/video_scaffold.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class SessionOneSpiritual extends StatefulWidget {
  static const String routeName = 'session1_spiritual_screen';

  @override
  _SessionOneSpiritualState createState() => _SessionOneSpiritualState();
}

class _SessionOneSpiritualState extends State<SessionOneSpiritual> {
  TargetPlatform _platform;
  VideoPlayerController _videoPlayerController1;
  VideoPlayerController _videoPlayerController2;
  VideoPlayerController _videoPlayerController3;
  VideoPlayerController _videoPlayerController4;
  ChewieController _chewieController;

  VideosList _videosList;
  bool _loading;
  PageInfo _pageInfo;

  @override
  void initState() {
    super.initState();
    _videoPlayerController1 =
        VideoPlayerController.asset('assets/session1/ae_ibne_adam_6.mp4');
    _videoPlayerController2 =
        VideoPlayerController.asset('assets/session1/Allah_Ki__7.mp4');
    _videoPlayerController3 =
        VideoPlayerController.asset('assets/session1/irfan_8.mkv');
    _videoPlayerController4 =
        VideoPlayerController.asset('assets/session1/Suratul_9.mp4');

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
        placeholder: Container(
          color: Colors.orangeAccent,
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
      if (item.video.title.contains('spirituality')) {
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
    _videoPlayerController2.dispose();
    _videoPlayerController3.dispose();
    _videoPlayerController4.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_loading ? 'loading...' : 'SPIRITUAL SESSIONS'),
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, MenuPage.routeName);
          },
        ),
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : Container(
              color: Colors.white,
              child: Column(
                children: [
                  Container(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _videosList.videos.length,
                      itemBuilder: (context, index) {
                        VideoItem videoItem = _videosList.videos[index];
                        return InkWell(
                          onTap: () async {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return VideoPlayerScreen(
                                videoItem: videoItem,
                              );
                            }));
                          },
                          child: Container(
                            height: 250,
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                CachedNetworkImage(
                                  width: 400,
                                  height: 300,
                                  fit: BoxFit.contain,
                                  imageUrl:
                                      videoItem.video.thumbnails.medium.url,
                                ),
                                const SizedBox(width: 16),
                                Text(videoItem.video.title,
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // ),
                ],
              ),
            ),

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
      //                 _videoPlayerController3.pause();
      //                 _videoPlayerController3.seekTo(Duration(seconds: 0));
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
      //         Expanded(
      //           child: TextButton(
      //             onPressed: () {
      //               setState(() {
      //                 _chewieController.dispose();
      //                 _videoPlayerController1.pause();
      //                 _videoPlayerController2.pause();
      //                 _videoPlayerController4.pause();
      //                 _videoPlayerController4.seekTo(Duration(seconds: 0));
      //                 _chewieController = ChewieController(
      //                   videoPlayerController: _videoPlayerController3,
      //                   aspectRatio: 3 / 2,
      //                   looping: false,
      //                   autoPlay: true,
      //                 );
      //               });
      //             },
      //             child: Padding(
      //               padding: EdgeInsets.symmetric(vertical: 16.0),
      //               child: Text("Video 3"),
      //             ),
      //           ),
      //         ),
      //         Expanded(
      //           child: TextButton(
      //             onPressed: () {
      //               setState(() {
      //                 _chewieController.dispose();
      //                 _videoPlayerController1.pause();
      //                 _videoPlayerController2.pause();
      //                 _videoPlayerController3.pause();
      //                 _chewieController = ChewieController(
      //                   videoPlayerController: _videoPlayerController4,
      //                   aspectRatio: 3 / 2,
      //                   looping: false,
      //                   autoPlay: true,
      //                 );
      //               });
      //             },
      //             child: Padding(
      //               padding: EdgeInsets.symmetric(vertical: 16.0),
      //               child: Text("Video 4"),
      //             ),
      //           ),
      //         )
      //       ],
      //     ),
      //   ],
      // ),
    );
  }
}
