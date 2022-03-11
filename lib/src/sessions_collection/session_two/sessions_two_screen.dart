// @dart=2.9

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:happy_shouket/src/localization/localization_constant.dart';
// import 'package:happy_shouket/src/screens/intervention_rating.dart';
import 'package:happy_shouket/src/screens/login_screen.dart';
import 'package:happy_shouket/src/sessions_collection/session_two/session_two_feedback.dart';
import 'package:happy_shouket/src/sessions_collection/session_two/session_two_pos.dart';
import 'package:happy_shouket/src/sessions_collection/session_two/session_two_psychoedu.dart';
import 'package:happy_shouket/src/sessions_collection/session_two/session_two_social.dart';
import 'package:happy_shouket/src/sessions_collection/session_two/session_two_spiritual.dart';
// import 'package:happy_shouket/src/widgets/session_intro_reusable_card.dart';
import 'package:happy_shouket/src/widgets/icon_content.dart';
import 'package:happy_shouket/src/widgets/reusable_card.dart';
import 'package:happy_shouket/src/widgets/session_intro_reusable_card.dart';

const activeCardColour = Color(0xFFd4b276);
const inactiveCardColour = Color(0xFFffce00);
final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
var userName = '';
// double _height;

enum CardType {
  mainMenu,
  psychoMed,
  positivePsycho,
  social,
  spiritual,
}

class SessionTwoScreen extends StatefulWidget {
  static const String routeName = 'sessions_two_screen';
  @override
  _SessionTwoScreenState createState() => _SessionTwoScreenState();
}

class _SessionTwoScreenState extends State<SessionTwoScreen> {
  CardType selectedCard;

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'session2')),
        actions: [
          TextButton(
            onPressed: () => {
              //sign out
              signOut()
            },
            child: Text(
              getTranslated(context, "signout"),
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
          margin: EdgeInsets.only(top: 15.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: IntroReusableCard(),
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ReusableCard(
                        onPress: () {
                          setState(() {
                            selectedCard = CardType.spiritual;
                            Navigator.pushNamed(
                                context, SessionTwoSpiritual.routeName);
                          });
                        },
                        colour: selectedCard == CardType.spiritual
                            ? activeCardColour
                            : inactiveCardColour,
                        cardChild: IconContent(
                          icon: FontAwesomeIcons.quran,
                          label: getTranslated(context, "spiritual"),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ReusableCard(
                        onPress: () {
                          setState(() {
                            selectedCard = CardType.positivePsycho;
                            Navigator.pushNamed(
                                context, SessionTwoPos.routeName);
                          });
                        },
                        colour: selectedCard == CardType.positivePsycho
                            ? activeCardColour
                            : inactiveCardColour,
                        cardChild: IconContent(
                          icon: FontAwesomeIcons.smileBeam,
                          label: getTranslated(context, "positive_psycho"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ReusableCard(
                        onPress: () {
                          setState(() {
                            selectedCard = CardType.psychoMed;
                            Navigator.pushNamed(
                                context, SessionTwoPsycho.routeName);
                          });
                        },
                        colour: selectedCard == CardType.psychoMed
                            ? activeCardColour
                            : inactiveCardColour,
                        cardChild: IconContent(
                          icon: FontAwesomeIcons.handHoldingMedical,
                          label: getTranslated(context, "psycho_med"),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ReusableCard(
                        onPress: () {
                          setState(() {
                            selectedCard = CardType.social;
                            Navigator.pushNamed(
                                context, SessionTwoSocial.routeName);
                          });
                        },
                        colour: selectedCard == CardType.social
                            ? activeCardColour
                            : inactiveCardColour,
                        cardChild: IconContent(
                          icon: FontAwesomeIcons.userFriends,
                          label: getTranslated(context, "social"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )

          // margin: EdgeInsets.only(bottom: 5),
          // child: SingleChildScrollView(
          // child: Column(
          // children: <Widget>[
          // Opacity(opacity: 0.88, child: CustomAppBar()),

          ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {
          Navigator.pushNamed(context, SessionTwoFeedbackScreen.routeName);
        },
        // Display the correct icon depending on the state of the player.
        child: Text(
          getTranslated(context, "next_button"),
        ),
      ),
    );
  }

  Future getUser() async {
    if (_auth.currentUser != null) {
      var cellNumber = _auth.currentUser.phoneNumber;
      cellNumber =
          '0' + _auth.currentUser.phoneNumber.substring(3, cellNumber.length);
      debugPrint(cellNumber);
      await _firestore
          .collection('users')
          .where('cellnumber', isEqualTo: cellNumber)
          .get()
          .then((result) {
        if (result.docs.length > 0) {
          setState(() {
            userName = result.docs[0].data()['name'];
          });
        }
      });
    } else
      return '';
  }

  signOut() {
    //redirect
    _auth.signOut().then((value) => Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen())));
  }
}
