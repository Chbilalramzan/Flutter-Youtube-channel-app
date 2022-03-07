// @dart=2.9

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:happy_shouket/src/models/videos_list.dart';
import 'package:happy_shouket/src/netwk/youtube.dart';
import 'package:happy_shouket/src/screens/intervention_rating.dart';
import 'package:happy_shouket/src/screens/youtube_player_view.dart';
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
  String _playListId;
  String _nextPageToken;
  ScrollController _scrollController;
  PageInfo _pageInfo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loading = true;
    _nextPageToken = '';
    _scrollController = ScrollController();
    _pageInfo = PageInfo(totalResults: 0, resultsPerPage: 0);
    _videosList = VideosList(
        etag: '', kind: '', nextPageToken: '', pageInfo: _pageInfo, videos: []);
    _videosList.videos = [];
    _getChannelInfo();
    print('Hello');
  }

  _getChannelInfo() async {
    await _loadVideos();
  }

  _loadVideos() async {
    VideosList tempVideosList = await Services.getVideosList();
    _nextPageToken = tempVideosList.nextPageToken;
    _videosList.videos.addAll(tempVideosList.videos);
    print('videos: ${_videosList.videos.length}');
    print('_nextPageToken $_nextPageToken');
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    ChewieController _chewieController;
    return Scaffold(
      appBar: AppBar(
        title:
            Text(_loading ? 'Loading...' : 'POSITIVE PSYCHOLOGY SESSION ONE'),
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
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(),
            // _buildInfoView(),
            Expanded(
              // child: NotificationListener<ScrollEndNotification>(
              //   onNotification: (ScrollNotification notification) {
              //     // if (_videosList.videos.length >=
              //     //     int.parse(_item.statistics.videoCount)) {
              //     //   return true;
              //     // }
              //     if (notification.metrics.pixels ==
              //         notification.metrics.maxScrollExtent) {
              //       _loadVideos();
              //     }
              //     return true;
              //   },
              child: _loading
                  ? CircularProgressIndicator()
                  : ListView.builder(
                      // controller: _scrollController,
                      itemCount: 6,
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
                                  imageUrl:
                                      videoItem.video.thumbnails.medium.url,
                                ),
                                const SizedBox(width: 16),
                                Text(videoItem.video.title),
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
