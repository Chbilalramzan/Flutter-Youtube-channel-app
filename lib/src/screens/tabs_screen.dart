import 'package:flutter/material.dart';
import 'package:happy_shouket/src/localization/localization_constant.dart';
import 'package:happy_shouket/src/providers/auth.dart';
// import 'package:happy_shouket/src/screens/about_us.dart';
import 'package:happy_shouket/src/screens/feedback_table.dart';
import 'package:happy_shouket/src/screens/home_screen.dart';
import '../sessions_collection/session_one/main_menu.dart';
// import 'package:happy_shouket/src/screens/sessions_two_screen.dart';
import 'package:happy_shouket/src/widgets/home_drawer.dart';
import 'package:happy_shouket/src/widgets/show_sign_out_dialog.dart';
import 'package:provider/provider.dart';

class TabsScreen extends StatefulWidget {
  static const String routeName = 'tabs_screen';

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, Object>> _pages = [
    {
      'page': HomeScreen(),
      'title': 'Happy Shouket Home',
    },
    {
      'page': MenuPage(),
      'title': 'Session One',
    },
    {
      'page': FeedbackData(),
      'title': 'Reports',
    },
  ];

  Future<void> _signOut() async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
      Navigator.of(context).pushReplacementNamed('/');
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(
      context,
      title: 'Logout',
      content: 'Are you sure that you want to Logout?',
      cancelActionText: 'Cancel',
      defaultActionText: 'Logout',
    );
    if (didRequestSignOut == true) {
      _signOut();
    }
  }

//   final List<Widget> _pages = [
//     HomeScreen(),
//     AboutUsScreen(),
//     SessionsScreen;
// ];
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // title: Text(_pages[_selectedPageIndex]['title']),
      //   actions: <Widget>[
      //     TextButton(
      //       onPressed: () => _confirmSignOut(context),
      //       child: Text(
      //         'Logout',
      //         style: TextStyle(
      //           fontSize: 20.0,
      //           color: Colors.black87,
      //           fontWeight: FontWeight.bold,
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      drawer: AppDrawer(),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        // type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.home),
            label: getTranslated(context, "home_page"),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.present_to_all),
            label: getTranslated(context, "session"),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.report),
            label: getTranslated(context, "reports"),
          ),
        ],
      ),
    );
  }
}
