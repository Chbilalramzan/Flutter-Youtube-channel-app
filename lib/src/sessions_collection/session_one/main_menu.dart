// @dart=2.9

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:happy_shouket/src/localization/localization_constant.dart';
import 'package:happy_shouket/src/screens/feedback_screen.dart';
import 'package:happy_shouket/src/screens/login_screen.dart';
import 'package:happy_shouket/src/sessions_collection/session_one/session1_social_screen.dart';
import 'package:happy_shouket/src/sessions_collection/session_one/session1_spiritual_screen.dart';
import 'session1_pospsycho_screen.dart';
import 'session1_psychoedu_screen.dart';
import '../../widgets/icon_content.dart';
import '../../widgets/reusable_card.dart';

const activeCardColour = Color(0xFFd4b276);
const inactiveCardColour = Color(0xFFf5e980);
final FirebaseAuth _auth = FirebaseAuth.instance;
// final FirebaseFirestore _firestore = FirebaseFirestore.instance;
var userName = '';
var phoneNumber = '';

enum CardType {
  mainMenu,
  psychoMed,
  positivePsycho,
  social,
  spiritual,
}

class MenuPage extends StatefulWidget {
  static const String routeName = 'main_menu';

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  CardType selectedCard;

  @override
  void initState() {
    // getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SESSION ONE'),
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
          // decoration: BoxDecoration(
          //     image: DecorationImage(
          //         fit: BoxFit.fitWidth,
          //         image: AssetImage('images/happyimogi.png'))),
          child: Column(
        children: <Widget>[
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
                          context, SessionOneEduItems.routeName);
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
                        selectedCard = CardType.positivePsycho;
                      });
                      Navigator.pushNamed(
                          context, SessionOnePosItems.routeName);
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
                        selectedCard = CardType.social;
                      });
                      Navigator.pushNamed(context, SessionOneSocial.routeName);
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
                Expanded(
                  child: ReusableCard(
                    onPress: () {
                      setState(() {
                        selectedCard = CardType.spiritual;
                      });
                      Navigator.pushNamed(
                          context, SessionOneSpiritual.routeName);
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
          Navigator.pushNamed(context, FeedbackScreen.routeName);
        },
        // Display the correct icon depending on the state of the player.
        child: Text('Next'),
      ),
    );
  }

  // Future getUser() async {
  //   if (_auth.currentUser != null) {
  //     var cellNumber = _auth.currentUser.phoneNumber;
  //     cellNumber =
  //         '0' + _auth.currentUser.phoneNumber.substring(3, cellNumber.length);
  //     debugPrint(cellNumber);
  //     await _firestore
  //         .collection('users')
  //         .where('cellnumber', isEqualTo: cellNumber)
  //         .get()
  //         .then((result) {
  //       if (result.docs.length > 0) {
  //         setState(() {
  //           userName = result.docs[0].data()['name'];
  //         });
  //       }
  //     });
  //   } else
  //     return '';
  // }

  signOut() {
    //redirect
    _auth.signOut().then((value) => Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen())));
  }
}
