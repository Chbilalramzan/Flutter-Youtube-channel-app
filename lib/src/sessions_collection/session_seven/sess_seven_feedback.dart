import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:happy_shouket/src/constants/constants.dart';
import 'package:happy_shouket/src/localization/localization_constant.dart';
import 'package:happy_shouket/src/screens/feedback_table.dart';
import 'package:happy_shouket/src/sessions_collection/session_three/session_three_screen.dart';
import 'package:happy_shouket/src/widgets/feedback_formfield.dart';
import 'package:happy_shouket/src/widgets/feedback_raisedfab.dart';

final firestoreInstance = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
User username;

class SessionSevenFeedbackScreen extends StatefulWidget {
  final String feedBackId;
  static const String routeName = 'session_seven_feedback_screen';

  const SessionSevenFeedbackScreen({Key key, this.feedBackId})
      : super(key: key);

  @override
  _SessionSevenFeedbackScreenState createState() =>
      _SessionSevenFeedbackScreenState();
}

class _SessionSevenFeedbackScreenState
    extends State<SessionSevenFeedbackScreen> {
  List<String> _questions = [
    'This engaging with session made me have a good time during dialysis?',
    'This activity during dialysis made my experience of dialysis better? ',
    'This information given during dialysis can improve my life? ',
    'I am looking forward to the next dialysis session because of the pleasant change due to using the app during dialysis.'
  ];
  List<int> _feedbackValue = [];

  List<bool> _isFormFieldComplete = [];

  String additionalComments;
  String feedBackId = "Session 7 feedback";

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < _questions.length; ++i) {
      _feedbackValue.add(-1);
      _isFormFieldComplete.add(false);
    }
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        username = user;
      }
    } catch (e) {
      print(e);
    }
  }

  dynamic getFeedback() {
    return FeedbackData();
  }

  void _handleRadioButton(int group, int value) {
    setState(() {
      _feedbackValue[group] = value;
      _isFormFieldComplete[group] = false;
    });
  }

  void handleSubmitFeedback() {
    bool complete = true;
    for (int i = 0; i < _feedbackValue.length; ++i) {
      if (_feedbackValue[i] == -1) {
        complete = false;
        _isFormFieldComplete[i] = true;
      } else {
        _isFormFieldComplete[i] = false;
      }
    }
    setState(() {});
    if (complete == true) {
      firestoreInstance
          .collection('feedback')
          .add({
            'user': username.uid,
            'feedbackId': feedBackId,
            'feedback': _feedbackValue,
            'comments': additionalComments,
          })
          .then((value) => print("User feedback Added"))
          .catchError((error) => "print(failed:$error)");
      print(_feedbackValue);
      print(additionalComments);
      Navigator.pushReplacementNamed(context, SessionThreeScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          getTranslated(context, "feedback_screen"),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Please choose appropriate emoji icon for your response',
                style: kFeedbackFormFieldTextStyle,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                getTranslated(context, "tons_emoji"),
                style: kFeedbackFormFieldTextStyle,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                getTranslated(context, "alot_emoji"),
                style: kFeedbackFormFieldTextStyle,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                getTranslated(context, "soso_emoji"),
                style: kFeedbackFormFieldTextStyle,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                getTranslated(context, "notgood_emoji"),
                style: kFeedbackFormFieldTextStyle,
              ),
              Divider(
                height: 25.0,
              ),
            ]
              ..addAll(
                _questions.asMap().entries.map((entry) {
                  return FeedbackFormField(
                    id: entry.key + 1,
                    question: entry.value,
                    groupValue: _feedbackValue[entry.key],
                    radioHandler: (int value) =>
                        _handleRadioButton(entry.key, value),
                    error: _isFormFieldComplete[entry.key]
                        ? 'This is a required field'
                        : null,
                  );
                }),
              )
              ..addAll([
                SizedBox(
                  height: 10.0,
                ),
                TextField(
                  decoration: kFeedbackFormFieldDecoration.copyWith(
                    hintText: 'Additional Comments (Optional)',
                  ),
                  maxLines: 5,
                  onChanged: (value) => additionalComments = value,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomRaisedButton(
                      save: handleSubmitFeedback,
                      title: 'Submit',
                    ),
                  ],
                ),
              ]),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, FeedbackData.routeName);
        },
        // Display the correct icon depending on the state of the player.
        child: Text('Test'),
      ),
    );
  }
}
