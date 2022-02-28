import 'package:flutter/foundation.dart';

class Contents {
  final String id;
  final String title;
  final String description;
  final String location;
  final bool isFavorite;

  Contents(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.location,
      this.isFavorite = false});
}
