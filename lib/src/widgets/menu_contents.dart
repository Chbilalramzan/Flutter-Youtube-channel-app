import 'package:flutter/foundation.dart';

enum ContentType {
  Videos,
  Images,
  Audios,
  Animated,
  Activity,
}

class MenuContents {
  final String id;
  final List<String> menus; //id from dummy_menus
  final String title;
  final String contentUrl;
  final ContentType contentType;

  const MenuContents({
    @required this.id,
    @required this.menus,
    @required this.title,
    @required this.contentUrl,
    @required this.contentType,
  });
}
