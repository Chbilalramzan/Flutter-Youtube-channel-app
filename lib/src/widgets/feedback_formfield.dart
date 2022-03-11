import 'package:flutter/material.dart';
import 'package:happy_shouket/src/constants/constants.dart';
import 'package:happy_shouket/src/localization/localization_constant.dart';
import 'package:happy_shouket/src/widgets/radio_emoji.dart';

class FeedbackFormField extends StatelessWidget {
  FeedbackFormField(
      {@required this.id,
      @required this.question,
      @required this.groupValue,
      @required this.radioHandler,
      this.error});

  /// `id` will be treated as a key and also the row number
  final int id;

  /// `question` you want to ask
  final String question;

  /// `groupValue` is used to identify if the radio button is selected or not
  ///
  /// if (groupValue == value) then it means that radio button is selected
  final int groupValue;

  /// `error` to be displayed below emojis row
  ///
  /// mostly used if no option is selected
  final String error;

  /// This function that will handle all radio button row values
  final Function radioHandler;

  /// Determines the number of radio buttons according to their taste
  ///
  /// 😕 😐 ☺ 😍
  static final List<int> _radioButtons = [1, 2, 3, 4];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          getTranslated(context, question),
          style: kFeedbackFormFieldTextStyle,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _radioButtons.map((value) {
            return RadioEmoji(
              value: value,
              groupValue: groupValue,
              onChange: radioHandler,
            );
          }).toList(),
        ),
        SizedBox(
          height: 2.0,
        ),
        Visibility(
          visible: error != null,
          child: Text(
            '$error',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
}
