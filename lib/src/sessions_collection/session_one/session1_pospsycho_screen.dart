// @dart=2.9

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:happy_shouket/src/localization/localization_constant.dart';
import 'package:happy_shouket/src/models/videos_list.dart';
import 'package:happy_shouket/src/netwk/youtube.dart';
import 'package:happy_shouket/src/screens/intervention_rating.dart';
import 'package:happy_shouket/src/screens/youtube_player_view.dart';
import 'package:happy_shouket/src/widgets/session_videos_list.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:happy_shouket/src/screens/video_items.dart';

class SessionOnePosItems extends StatefulWidget {
  static const String routeName = 'session1_positive_screen';

  @override
  State<SessionOnePosItems> createState() => _SessionOnePosItemsState();
}

class _SessionOnePosItemsState extends State<SessionOnePosItems> {
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
      if (item.video.title.contains('psychology') &&
          item.video.title.contains('Session 1')) {
        _videosList.videos.add(item);
      }
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    ChewieController _chewieController;
    return Scaffold(
      appBar: AppBar(
        title: Text(_loading
            ? 'Loading...'
            : getTranslated(context, 'positive_psycho')),
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
          : SessionVideosList(videosList: _videosList),
      //  ListView(
      //   children: <Widget>[
      //     VideoItems(
      //       videoPlayerController:
      //           VideoPlayerController.asset('assets/session1/rumi_1.mp4'),
      //       looping: true,
      //       autoplay: true,
      //     ),
      //     VideoItems(
      //       videoPlayerController:
      //           VideoPlayerController.asset('assets/session1/amir_3.mp4'),
      //       looping: true,
      //       autoplay: true,
      //     ),
      //     VideoItems(
      //       videoPlayerController:
      //           VideoPlayerController.asset('assets/session1/amir_3.mp4'),
      //       looping: true,
      //       autoplay: true,
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
      //   ],
      // ),
    );
  }
}
