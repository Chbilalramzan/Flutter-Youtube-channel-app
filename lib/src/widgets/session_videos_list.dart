import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:happy_shouket/src/models/videos_list.dart';
import 'package:happy_shouket/src/screens/youtube_player_view.dart';

class SessionVideosList extends StatelessWidget {
  const SessionVideosList({
    Key key,
    @required VideosList videosList,
  })  : _videosList = videosList,
        super(key: key);

  final VideosList _videosList;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                          imageUrl: videoItem.video.thumbnails.medium.url,
                        ),
                        const SizedBox(width: 16),
                        Text(videoItem.video.title,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w500)),
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
    );
  }
}
