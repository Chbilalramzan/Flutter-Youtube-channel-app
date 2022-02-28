import 'package:flutter/material.dart';
import '../models/contents.dart';
import '../widgets/contents_item.dart';

class PositivePsychoScreen extends StatelessWidget {
  static const String routeName = 'positivepsycho_screen';

  final List<Contents> loadedContents = [
    Contents(
        id: 'c1',
        title: 'Amir',
        description: 'Positive Psycho First',
        location:
            'https://www.youtube.com/watch?app=desktop&v=6tN9wMbdqZU&list=PLYd3tI79bfu8kMdopG6dDJsGw_HUnFIy4&index=8&t=0s'),
    Contents(
        id: 'c2',
        title: 'Resource Haemodialysis',
        description: 'Positive Psycho Second',
        location:
            'https://www.youtube.com/watch?app=desktop&v=6tN9wMbdqZU&list=PLYd3tI79bfu8kMdopG6dDJsGw_HUnFIy4&index=8&t=0s'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Positive Psychology'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all((10.0)),
        itemCount: loadedContents.length,
        itemBuilder: (context, i) => ContentsItem(
          loadedContents[i].id,
          loadedContents[i].title,
          loadedContents[i].location,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
