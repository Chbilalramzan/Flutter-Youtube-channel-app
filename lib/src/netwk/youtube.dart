import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:happy_shouket/src/constants/urls.dart';
import 'package:happy_shouket/src/models/videos_list.dart';
import 'package:http/http.dart';

class Services {
  static Future<VideosList> getVideosList() async {
    Map<String, dynamic> parameters = {
      'part': 'snippet,id',
      'channelId': Url.YOUTUBE_CHANNEL_ID,
      'maxResults': '51',
      'key': Url.YOUTUBE_API_KEY,
      'mine': 'true',
      'order': 'date'
    };
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    Uri uri = Uri.https(
      Url.YOUTUBE_BASE_URL,
      'search',
      parameters,
    );
    Response response = await http.get(uri, headers: headers);
    print(response.body);
    VideosList videosList = videosListFromJson(response.body);
    return videosList;
  }
}
