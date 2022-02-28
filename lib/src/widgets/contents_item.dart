import 'package:flutter/material.dart';

class ContentsItem extends StatelessWidget {
  final String id;
  final String title;
  final String location;

  const ContentsItem(this.id, this.title, this.location);

  @override
  Widget build(BuildContext context) {
    return GridTile(child: Image.network(location));
  }
}
