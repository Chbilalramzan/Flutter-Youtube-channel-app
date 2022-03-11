import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:happy_shouket/src/localization/localization_constant.dart';
import 'package:happy_shouket/src/sessions_collection/session_two/sessions_two_screen.dart';

class PosRatingScreen extends StatefulWidget {
  static const String routeName = 'pos_rating_screen';

  @override
  _PosRatingScreenState createState() => _PosRatingScreenState();
}

class _PosRatingScreenState extends State<PosRatingScreen> {
  double _ratingValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      // _myAppBar(),
                      Container(
                        color: Color(0xffE5E5E5),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Container(
                                    child: Text(
                                  getTranslated(context, 'rating_Text'),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                            ),
                            SizedBox(height: 30.0),
                            RatingBar(
                                initialRating: 0,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                ratingWidget: RatingWidget(
                                    full:
                                        Icon(Icons.star, color: Colors.orange),
                                    half: Icon(
                                      Icons.star_half,
                                      color: Colors.orange,
                                    ),
                                    empty: Icon(
                                      Icons.star_outline,
                                      color: Colors.orange,
                                    )),
                                onRatingUpdate: (value) {
                                  setState(() {
                                    _ratingValue = value;
                                  });
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton.large(
      //   onPressed: () {
      //     Navigator.pushNamed(context, SessionTwoScreen.routeName);
      //   },
      //   // Display the correct icon depending on the state of the player.
      //   child: Text(getTranslated(context, "next_button")),
      //   backgroundColor: const Color(0xFF19c916),
      // ),
    );
  }
}
