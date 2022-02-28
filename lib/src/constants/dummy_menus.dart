import '../widgets/menus.dart';
import 'package:flutter/material.dart';
import '../widgets/menu_contents.dart';

const DUMMY_MENUS = const [
  Menus(
    id: 'm1',
    label: 'PSYCHOLOGICAL EDUCATION',
    colour: Color(0xFFf5e980),
  ),
  Menus(
    id: 'm2',
    label: 'POSITIVE PSYCHOLOGY',
    colour: Colors.orange,
  ),
  Menus(
    id: 'm3',
    label: 'SOCIAL',
    colour: Colors.amber,
  ),
  Menus(
    id: 'm4',
    label: 'SPIRITUAL',
    colour: Colors.green,
  ),
];

const DUMMY_CONTENT = const [
  MenuContents(
    id: 'mc1',
    menus: [
      'm1',
      'm2',
    ],
    title: 'Renal Rehab',
    contentUrl: 'https://www.youtube.com/watch?v=PpQfqp8cIe0&feature=emb_logo',
    contentType: ContentType.Videos,
  ),
  MenuContents(
    id: 'mc2',
    menus: [
      'm1',
    ],
    title: 'Exercise during dialysis',
    contentUrl: 'https://www.youtube.com/watch?v=nm2yWR6Unao',
    contentType: ContentType.Videos,
  ),
  MenuContents(
    id: 'mc3',
    menus: [
      'm2',
    ],
    title: 'Learned Optimism',
    contentUrl:
        'https://www.youtube.com/watch?app=desktop&v=6tN9wMbdqZU&list=PLYd3tI79bfu8kMdopG6dDJsGw_HUnFIy4&index=8&t=0s',
    contentType: ContentType.Animated,
  ),
  MenuContents(
    id: 'mc4',
    menus: [
      'm3',
    ],
    title: 'Learn from Others',
    contentUrl: 'https://www.youtube.com/watch?v=S8mpXUeAg3Q',
    contentType: ContentType.Videos,
  ),
  MenuContents(
    id: 'mc5',
    menus: ['m4,'],
    title: 'Spiritual Quotes',
    contentUrl: 'https://www.youtube.com/watch?v=oI7sm-xxo_Q',
    contentType: ContentType.Audios,
  ),
];
