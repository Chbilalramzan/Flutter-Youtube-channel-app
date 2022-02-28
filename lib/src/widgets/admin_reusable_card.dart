import 'package:flutter/material.dart';
import '../screens/admin_menu_content.dart';

class ReusableCard extends StatelessWidget {
  final String id;
  final String label;
  final Color colour;
  // final Widget cardChild;
  // final Function onPress;

  //commented out bottom reusableCard constructor, @require for colour, and onPressed

  ReusableCard(
    this.id,
    this.colour,
    this.label,
    // this.cardChild,
    // this.onPress,
  );

  // ReusableCard({
  //   this.id,
  //   @required this.colour,
  //   this.cardChild,
  //   this.onPress,
  // });
  // const ReusableCard({Key key,}) : super(key: key);

  void selectedMenu(BuildContext context) {
    Navigator.of(context).pushNamed(
      AdminMenuContents.routeName,
      arguments: {
        'id': id,
        'label': label,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectedMenu(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15.0),
      child: Container(
        // child: cardChild,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colour.withOpacity(0.7),
              colour,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}
