import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:happy_shouket/src/localization/localization_constant.dart';
import 'package:happy_shouket/src/screens/intervention_rating.dart';
import 'package:happy_shouket/src/screens/login_screen.dart';
import 'package:happy_shouket/src/sessions_collection/session_four/sess_four_positive.dart';
import 'package:happy_shouket/src/sessions_collection/session_four/sess_four_psychoedu.dart';
import 'package:happy_shouket/src/sessions_collection/session_four/sess_four_social.dart';
import 'package:happy_shouket/src/sessions_collection/session_four/sess_four_spiritual.dart';
import 'package:happy_shouket/src/sessions_collection/session_four/session_four_feedback.dart';
import 'package:happy_shouket/src/widgets/session_intro_reusable_card.dart';
import '../session_one/session1_psychoedu_screen.dart';
import 'package:happy_shouket/src/widgets/icon_content.dart';
import 'package:happy_shouket/src/widgets/reusable_card.dart';

const activeCardColour = Color(0xFFd4b276);
const inactiveCardColour = Color(0xFFe3dd5a);
final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
var userName = '';

enum CardType {
  mainMenu,
  psychoMed,
  positivePsycho,
  social,
  spiritual,
}

class SessionFourScreen extends StatefulWidget {
  static const String routeName = 'sessions_four_screen';
  @override
  _SessionFourScreenState createState() => _SessionFourScreenState();
}

class _SessionFourScreenState extends State<SessionFourScreen> {
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
        title: Text('SESSION FOUR'),
        actions: [
          TextButton(
            onPressed: () => {
              //sign out
              signOut()
            },
            child: Text(
              'Sign out',
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
                          });
                          Navigator.pushNamed(
                              context, SessionFourSpiritual.routeName);
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
                          });
                          Navigator.pushNamed(
                              context, SessionFourPosPsycho.routeName);
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
                          });
                          Navigator.pushNamed(
                              context, SessionFourPsychoEdu.routeName);
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
                          });
                          Navigator.pushNamed(
                              context, SessionFourSocial.routeName);
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.pushNamed(context, EduRatingScreen.routeName);
          Navigator.pushNamed(context, SessionFourFeedbackScreen.routeName);
        },
        // Display the correct icon depending on the state of the player.
        child: Text('Next'),
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
