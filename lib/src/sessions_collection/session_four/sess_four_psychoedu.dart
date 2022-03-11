import 'package:flutter/material.dart';
import 'package:happy_shouket/src/localization/localization_constant.dart';
import 'package:happy_shouket/src/models/videos_list.dart';
import 'package:happy_shouket/src/netwk/youtube.dart';
import 'package:happy_shouket/src/screens/intervention_rating.dart';
import 'package:happy_shouket/src/widgets/session_videos_list.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:happy_shouket/src/screens/video_items.dart';

class SessionFourPsychoEdu extends StatefulWidget {
  static const String routeName = 'session4_psychoedu_screen';

  @override
  State<SessionFourPsychoEdu> createState() => _SessionFourPsychoEduState();
}

class _SessionFourPsychoEduState extends State<SessionFourPsychoEdu> {
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
          item.video.title.contains('Session 4')) {
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
          title: Text(getTranslated(context, "psycho_med") +
              " " +
              getTranslated(context, "session4")),
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
        // ListView(
        //   children: <Widget>[
        //     VideoItems(
        //       videoPlayerController:
        //           VideoPlayerController.asset('assets/session4/Water.mp4'),
        //       looping: true,
        //       autoplay: true,
        //     ),
        //     VideoItems(
        //       videoPlayerController:
        //           VideoPlayerController.asset('assets/session4/How_much_iam.mp4'),
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
