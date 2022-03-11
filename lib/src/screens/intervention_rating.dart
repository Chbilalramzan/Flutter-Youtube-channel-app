import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:happy_shouket/src/constants/constants.dart';
import 'package:happy_shouket/src/localization/localization_constant.dart';
import '../sessions_collection/session_one/session1_pospsycho_screen.dart';

import '../sessions_collection/session_two/sessions_two_screen.dart';

class EduRatingScreen extends StatefulWidget {
  static const String routeName = 'edu_rating_screen';

  @override
  _EduRatingScreenState createState() => _EduRatingScreenState();
}

class _EduRatingScreenState extends State<EduRatingScreen> {
  var myFeedbackText = "Not good";
  var sliderValue = 0.0;
  IconData myFeedback1 = FontAwesomeIcons.star,
      myFeedback2 = FontAwesomeIcons.star,
      myFeedback3 = FontAwesomeIcons.star,
      myFeedback4 = FontAwesomeIcons.star,
      myFeedback5 = FontAwesomeIcons.star;
  Color myFeedbackColor1 = Colors.grey,
      myFeedbackColor2 = Colors.grey,
      myFeedbackColor3 = Colors.grey,
      myFeedbackColor4 = Colors.grey,
      myFeedbackColor5 = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _myAppBar(),
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
                Container(
                  child: Align(
                    child: Material(
                      color: Colors.white,
                      elevation: 14.0,
                      borderRadius: BorderRadius.circular(24.0),
                      shadowColor: Color(0x802196F3),
                      child: Container(
                          width: 350.0,
                          height: 300.0,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: StarWidget(),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Slider(
                                    min: 0.0,
                                    max: 5.0,
                                    divisions: 5,
                                    value: sliderValue,
                                    activeColor: Colors.deepOrangeAccent,
                                    inactiveColor: Colors.blueGrey,
                                    onChanged: (newValue) {
                                      setState(() {
                                        sliderValue = newValue;
                                        if (sliderValue == 1.0) {
                                          myFeedback1 =
                                              FontAwesomeIcons.solidStar;
                                          myFeedbackColor1 = Colors.yellow;
                                        } else if (sliderValue < 1.0) {
                                          myFeedback1 = FontAwesomeIcons.star;
                                          myFeedbackColor1 = Colors.grey;
                                        }
                                        if (sliderValue == 2.0) {
                                          myFeedback2 =
                                              FontAwesomeIcons.solidStar;
                                          myFeedbackColor2 = Colors.yellow;
                                        } else if (sliderValue < 2.0) {
                                          myFeedback2 = FontAwesomeIcons.star;
                                          myFeedbackColor2 = Colors.grey;
                                        }
                                        if (sliderValue == 3.0) {
                                          myFeedback3 =
                                              FontAwesomeIcons.solidStar;
                                          myFeedbackColor3 = Colors.yellow;
                                        } else if (sliderValue < 3.0) {
                                          myFeedback3 = FontAwesomeIcons.star;
                                          myFeedbackColor3 = Colors.grey;
                                        }
                                        if (sliderValue == 4.0) {
                                          myFeedback4 =
                                              FontAwesomeIcons.solidStar;
                                          myFeedbackColor4 = Colors.yellow;
                                        } else if (sliderValue < 4.0) {
                                          myFeedback4 = FontAwesomeIcons.star;
                                          myFeedbackColor4 = Colors.grey;
                                        }
                                        if (sliderValue == 5.0) {
                                          myFeedback5 =
                                              FontAwesomeIcons.solidStar;
                                          myFeedbackColor5 = Colors.yellow;
                                        } else if (sliderValue < 5.0) {
                                          myFeedback5 = FontAwesomeIcons.star;
                                          myFeedbackColor5 = Colors.grey;
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Container(
                                    child: Text(
                                  getTranslated(context, "your_rating") +
                                      " : $sliderValue",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    color: Color(0xFF19c916),
                                    child: Text(
                                      getTranslated(context, "submit_button"),
                                      style:
                                          TextStyle(color: Color(0xffffffff)),
                                    ),
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(context,
                                          SessionOnePosItems.routeName);
                                    },
                                  ),
                                )),
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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

  List<Widget> StarWidget() {
    List<Widget> myContainer = new List();
    myContainer.add(Container(
        child: Icon(
      myFeedback1,
      color: myFeedbackColor1,
      size: 50.0,
    )));
    myContainer.add(Container(
        child: Icon(
      myFeedback2,
      color: myFeedbackColor2,
      size: 50.0,
    )));
    myContainer.add(Container(
        child: Icon(
      myFeedback3,
      color: myFeedbackColor3,
      size: 50.0,
    )));
    myContainer.add(Container(
        child: Icon(
      myFeedback4,
      color: myFeedbackColor4,
      size: 50.0,
    )));
    myContainer.add(Container(
        child: Icon(
      myFeedback5,
      color: myFeedbackColor5,
      size: 50.0,
    )));
    return myContainer;
  }

  Widget _myAppBar() {
    return Container(
      height: 70.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFf5e980),
            const Color(0xFF19c916),
          ],
          begin: Alignment.centerRight,
          end: new Alignment(-1.0, -1.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.arrowLeft,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      //
                    }),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                child: Text(
                  getTranslated(context, 'rating_Text1'),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 22.0),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.arrowAltCircleRight,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, SessionTwoScreen.routeName);
                    }),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
