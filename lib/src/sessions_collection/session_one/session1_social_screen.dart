import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:happy_shouket/src/models/videos_list.dart';
import 'package:happy_shouket/src/netwk/youtube.dart';
import 'package:happy_shouket/src/screens/intervention_rating.dart';
import 'package:happy_shouket/src/screens/youtube_player_view.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:happy_shouket/src/screens/video_items.dart';

class SessionOneSocial extends StatefulWidget {
  static const String routeName = 'session1_social_screen';

  @override
  State<SessionOneSocial> createState() => _SessionOneSocialState();
}

class _SessionOneSocialState extends State<SessionOneSocial> {
  ChewieController _chewieController;
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
      if (item.video.title.contains('social') &&
          item.video.title.contains('Session 1')) {
        _videosList.videos.add(item);
      }
    }
    print('videos: ${_videosList.videos.length}');
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_loading ? 'loading...' : 'SOCIAL SESSION'),
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
      // ListView(
      //   children: <Widget>[
      //     VideoItems(
      //       videoPlayerController: VideoPlayerController.asset(
      //           'assets/session1/RESOURCE_SAMAJI_5.mp4'),
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
