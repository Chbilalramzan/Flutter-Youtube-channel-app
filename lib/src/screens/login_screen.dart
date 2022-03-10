import 'package:flutter/material.dart';
import 'package:happy_shouket/src/classes/language.dart';
import 'package:happy_shouket/src/localization/localization_constant.dart';
import 'package:happy_shouket/src/models/http_exception.dart';
import 'package:happy_shouket/src/providers/auth.dart';

import 'package:happy_shouket/src/screens/home_screen.dart';

import 'package:happy_shouket/src/screens/phone_auth_screen.dart';
import '../sessions_collection/session_one/session1_psychoedu_screen.dart';
// import 'package:happy_shouket/src/screens/main_menu.dart';
import 'package:happy_shouket/src/screens/signup_screen.dart';
import 'package:happy_shouket/src/screens/tabs_screen.dart';
import 'package:happy_shouket/src/screens/test_video_player.dart';
// import 'package:happy_shouket/src/screens/video_player_test.dart';
import 'package:happy_shouket/src/widgets/clip_shape.dart';
import 'package:happy_shouket/src/widgets/customappbar.dart';
import '../app.dart';
import '../widgets/responsive_ui.dart';
import '../classes/language.dart';
import 'package:provider/provider.dart';

double _height;
double _width;
double _pixelRatio;
bool _large;
bool _medium;

enum AuthMode { Signup, Login }

class LoginScreen extends StatelessWidget {
  static const String routeName = 'login_screen';

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    return Material(
      child: Scaffold(
        // drawer: _drawerList(),
        body: Container(
          height: _height,
          width: _width,
          padding: EdgeInsets.only(bottom: 30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Opacity(opacity: 0.88, child: CustomAppBar()),
                ClipShape(),
                AuthForm(),
                SizedBox(
                  height: _height / 35,
                ),
                Container(margin: EdgeInsets.only(bottom: 150.0)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  // final _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  String get _email => _emailController.text;
  String get _password => _emailController.text;

  @override
  void initState() {
    // TODO: implement initState
    // Locale _temp = await setLocale('ur');
    // MyApp.setLocale(context, _temp);
    super.initState();
  }

  void _changeLanguage(Language language) async {
    Locale _temp = await setLocale(language.languageCode);
    MyApp.setLocale(context, _temp);
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      if (_authMode == AuthMode.Login) {
        // Log user in
        await auth.login(
          _authData['email'],
          _authData['password'],
        );
        Navigator.pushNamed(context, TabsScreen.routeName);
      } else {
        // Sign user up
        await auth.signup(
          _authData['email'],
          _authData['password'],
        );
        Navigator.pushNamed(context, TabsScreen.routeName);
        // Navigator.pushNamed(context, HomeScreen.routeName);
      }
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _emailEditingComplete() {
    FocusScope.of(context).requestFocus(_passwordFocusNode);
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: _width / 12.0, right: _width / 12.0, top: _height / 20.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                  left: _width / 60, top: _height / 20, bottom: 10.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text(
                      getTranslated(context, 'welcome_note'),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: _large ? 25 : (_medium ? 50 : 40),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: _height / 60.0),
            Container(
              margin: EdgeInsets.only(left: _width / 60.0, bottom: 30.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text(
                      getTranslated(context, "signin_note"),
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: _large ? 18 : (_medium ? 25 : 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: _height / 60.0),
            TextFormField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              autocorrect: false,
              textInputAction: TextInputAction.next,
              focusNode: _emailFocusNode,
              onEditingComplete: _emailEditingComplete,
              enabled: _isLoading == false,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 10.0),
                  child: Icon(Icons.email, color: Colors.orange[200], size: 20),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.lightGreenAccent, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.lightGreenAccent, width: 3.0),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                hintText: getTranslated(context, "email_hint"),
                labelText: getTranslated(context, "email_address"),
              ),
              validator: (value) {
                if (value.isEmpty || !value.contains('@')) {
                  return 'Invalid email!';
                }
                return null;
              },
              onSaved: (value) {
                _authData['email'] = value;
              },
            ),
            SizedBox(height: _height / 60.0),
            TextFormField(
              textAlign: TextAlign.center,
              obscureText: true,
              controller: _passwordController,
              focusNode: _passwordFocusNode,
              autocorrect: false,
              textInputAction: TextInputAction.done,
              onEditingComplete: _submit,
              enabled: _isLoading == false,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 10.0),
                  child: Icon(Icons.lock, color: Colors.orange[200], size: 20),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.lightGreenAccent, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.lightGreenAccent, width: 3.0),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                hintText: getTranslated(context, "password_hint"),
                labelText: getTranslated(context, "password"),
              ),
              validator: (value) {
                if (value.isEmpty || value.length < 5) {
                  return 'Password is too short!';
                }
              },
              onSaved: (value) {
                _authData['password'] = value;
              },
            ),
            SizedBox(height: _height / 60.0),
            if (_authMode == AuthMode.Signup)
              TextFormField(
                enabled: _authMode == AuthMode.Signup,
                textAlign: TextAlign.center,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsetsDirectional.only(start: 10.0),
                    child:
                        Icon(Icons.lock, color: Colors.orange[200], size: 20),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.lightGreenAccent, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.lightGreenAccent, width: 3.0),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  labelText: getTranslated(context, "reenter_password"),
                  hintText: getTranslated(context, "reenter_password"),
                ),
                validator: _authMode == AuthMode.Signup
                    ? (value) {
                        if (value != _passwordController.text) {
                          return 'Passwords do not match!';
                        }
                      }
                    : null,
              ),

            SizedBox(height: _height / 60.0),
            if (_isLoading)
              CircularProgressIndicator()
            else
              RaisedButton(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0)),
                color: Colors.blue,

                // Navigator.pushNamed(context, MenuPage.routeName);
                //   }
                // : null,

                textColor: Colors.black,
                padding: EdgeInsets.all(0.0),
                child: Container(
                  alignment: Alignment.center,
                  width: _large
                      ? _width / 4
                      : (_medium ? _width / 3.75 : _width / 3.5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    gradient: LinearGradient(
                      colors: <Color>[Color(0xFFf5e980), Color(0xFF19c916)],
                    ),
                  ),
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                      _authMode == AuthMode.Login
                          ? getTranslated(context, "login_buttontext")
                          : getTranslated(context, "signup_buttontext"),
                      style: TextStyle(
                          fontSize: _large ? 14 : (_medium ? 12 : 10))),
                ),
                onPressed: !_isLoading ? _submit : null,
              ),
            SizedBox(height: _height / 60.0),
            Container(
              margin: EdgeInsets.only(top: _height / 120.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '${_authMode == AuthMode.Login ? getTranslated(context, "no_useraccount") : getTranslated(context, "got_useraccount")}',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: _large ? 19 : (_medium ? 12 : 10)),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: !_isLoading ? _switchAuthMode : null,
                    //     () {
                    //
                    //   Navigator.pushNamed(context, SignUpScreen.routeName);
                    //   print("Routing to Sign up screen");
                    // },
                    child: Text(
                      '${_authMode == AuthMode.Login ? getTranslated(context, "signup_buttontext") : getTranslated(context, "login_buttontext")}',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.blue[500],
                          fontSize: _large ? 19 : (_medium ? 17 : 15)),
                    ),
                  )
                ],
              ),
            ),
            // SizedBox(height: _height / 60.0),
            // signUpTextRow(context),
            SizedBox(
              height: _height / 35,
            ),
            signinMobile(context),
            SizedBox(
              height: _height / 70,
            ),
            translator(context),
          ],
        ),
      ),
    );
  }
  //
  // Widget welcomeTextRow(BuildContext context) {}
  //
  // Widget signInTextRow(BuildContext context) {
  //   return Container(
  //     margin: EdgeInsets.only(left: _width / 60.0, bottom: 30.0),
  //     child: Row(
  //       children: <Widget>[
  //         Expanded(
  //           flex: 1,
  //           child: Text(
  //             getTranslated(context, "signin_note"),
  //             style: TextStyle(
  //               fontWeight: FontWeight.w300,
  //               fontSize: _large ? 18 : (_medium ? 25 : 15),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget emailField() {
  //   return TextFormField(
  //     textAlign: TextAlign.center,
  //     keyboardType: TextInputType.emailAddress,
  //     decoration: InputDecoration(
  //       prefixIcon: Padding(
  //         padding: const EdgeInsetsDirectional.only(start: 10.0),
  //         child: Icon(Icons.email, color: Colors.orange[200], size: 20),
  //       ),
  //       contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.all(Radius.circular(32.0)),
  //       ),
  //       enabledBorder: OutlineInputBorder(
  //         borderSide: BorderSide(color: Colors.lightGreenAccent, width: 1),
  //         borderRadius: BorderRadius.all(Radius.circular(25.0)),
  //       ),
  //       focusedBorder: OutlineInputBorder(
  //         borderSide: BorderSide(color: Colors.lightGreenAccent, width: 3.0),
  //         borderRadius: BorderRadius.all(Radius.circular(20.0)),
  //       ),
  //       hintText: getTranslated(context, "email_hint"),
  //       labelText: getTranslated(context, "email_address"),
  //     ),
  //     validator: (value) {
  //       if (value.isEmpty || !value.contains('@')) {
  //         return 'Invalid email!';
  //       }
  //       return null;
  //     },
  //     onSaved: (value) {
  //       _authData['email'] = value;
  //     },
  //   );
  // }
  //
  // Widget passwordField() {
  //   return TextFormField(
  //     textAlign: TextAlign.center,
  //     obscureText: true,
  //     decoration: InputDecoration(
  //       prefixIcon: Padding(
  //         padding: const EdgeInsetsDirectional.only(start: 10.0),
  //         child: Icon(Icons.lock, color: Colors.orange[200], size: 20),
  //       ),
  //       contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.all(Radius.circular(32.0)),
  //       ),
  //       enabledBorder: OutlineInputBorder(
  //         borderSide: BorderSide(color: Colors.lightGreenAccent, width: 1),
  //         borderRadius: BorderRadius.all(Radius.circular(25.0)),
  //       ),
  //       focusedBorder: OutlineInputBorder(
  //         borderSide: BorderSide(color: Colors.lightGreenAccent, width: 3.0),
  //         borderRadius: BorderRadius.all(Radius.circular(20.0)),
  //       ),
  //       hintText: getTranslated(context, "password_hint"),
  //       labelText: getTranslated(context, "password"),
  //     ),
  //     validator: (value) {
  //       if (value.isEmpty || value.length < 5) {
  //         return 'Password is too short!';
  //       }
  //     },
  //     onSaved: (value) {
  //       _authData['password'] = value;
  //     },
  //   );
  // }

  // Widget repasswordTextFormField() {
  //   return TextFormField(
  //     enabled: _authMode == AuthMode.Signup,
  //     textAlign: TextAlign.center,
  //     obscureText: true,
  //     decoration: InputDecoration(
  //       prefixIcon: Padding(
  //         padding: const EdgeInsetsDirectional.only(start: 10.0),
  //         child: Icon(Icons.lock, color: Colors.orange[200], size: 20),
  //       ),
  //       contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.all(Radius.circular(32.0)),
  //       ),
  //       enabledBorder: OutlineInputBorder(
  //         borderSide: BorderSide(color: Colors.lightGreenAccent, width: 1),
  //         borderRadius: BorderRadius.all(Radius.circular(25.0)),
  //       ),
  //       focusedBorder: OutlineInputBorder(
  //         borderSide: BorderSide(color: Colors.lightGreenAccent, width: 3.0),
  //         borderRadius: BorderRadius.all(Radius.circular(20.0)),
  //       ),
  //       hintText: getTranslated(context, "reenter_password"),
  //     ),
  //     validator: _authMode == AuthMode.Signup
  //         ? (value) {
  //             if (value != _passwordController.text) {
  //               return 'Passwords do not match!';
  //             }
  //           }
  //         : null,
  //   );
  // }
  //
  // Widget submitButton() {
  //   return RaisedButton(
  //     elevation: 0,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
  //     color: Colors.blue,
  //
  //     // Navigator.pushNamed(context, MenuPage.routeName);
  //     //   }
  //     // : null,
  //
  //     textColor: Colors.black,
  //     padding: EdgeInsets.all(0.0),
  //     child: Container(
  //       alignment: Alignment.center,
  //       width: _large ? _width / 4 : (_medium ? _width / 3.75 : _width / 3.5),
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.all(Radius.circular(20.0)),
  //         gradient: LinearGradient(
  //           colors: <Color>[Color(0xFFf5e980), Color(0xFF19c916)],
  //         ),
  //       ),
  //       padding: const EdgeInsets.all(12.0),
  //       child: Text(
  //           _authMode == AuthMode.Login
  //               ? getTranslated(context, "login_buttontext")
  //               : getTranslated(context, "signup_buttontext"),
  //           style: TextStyle(fontSize: _large ? 14 : (_medium ? 12 : 10))),
  //     ),
  //     onPressed: _submit,
  //   );
  // }

  // Widget switchMode() {
  //   FlatButton(
  //     child:
  //         Text('${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
  //     onPressed: _switchAuthMode,
  //     padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
  //     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  //     textColor: Theme.of(context).primaryColor,
  //   );
  // }
  //
  // Widget signUpTextRow(BuildContext context) {
  //   return Container(
  //     margin: EdgeInsets.only(top: _height / 120.0),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: <Widget>[
  //         Text(
  //           getTranslated(context, "no_useraccount"),
  //           style: TextStyle(
  //               fontWeight: FontWeight.w400,
  //               fontSize: _large ? 19 : (_medium ? 12 : 10)),
  //         ),
  //         SizedBox(
  //           width: 5,
  //         ),
  //         GestureDetector(
  //           onLongPress: _switchAuthMode,
  //           //     () {
  //           //
  //           //   Navigator.pushNamed(context, SignUpScreen.routeName);
  //           //   print("Routing to Sign up screen");
  //           // },
  //           child: Text(
  //           '${_authMode == AuthMode.Login ? getTranslated(context, "signup_buttontext") : getTranslated(context, "login_buttontext")} INSTEAD',
  //             style: TextStyle(
  //                 fontWeight: FontWeight.w800,
  //                 color: Colors.blue[500],
  //                 fontSize: _large ? 19 : (_medium ? 17 : 15)),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  Widget signinMobile(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: _height / 120.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () async {
              // await Navigator.pushNamed(context, HomeScreen.routeName);
              await Navigator.pushNamed(context, MobileAuthScreen.routeName);
              print("Routing to Sign up screen");
            },
            child: Text(
              getTranslated(context, "mobile_signin"),
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.blue[500],
                  fontSize: _large ? 19 : (_medium ? 17 : 15)),
            ),
          )
        ],
      ),
    );
  }

  Widget translator(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: _height / 20.0),
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(getTranslated(context, "Language"),
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                    fontSize: _large ? 19 : (_medium ? 17 : 15))),
            // height: 50.0,
            // alignment: Alignment.center,
            // padding: EdgeInsets.only(bottom: 20.0),
            // color: Color.fromRGBO(255, 254, 229, 1),
            DropdownButton(
              onChanged: (Language language) {
                _changeLanguage(language);
              },
              underline: SizedBox(),
              icon: Icon(
                Icons.language,
                size: 40.0,
                color: Colors.orange,
                semanticLabel: 'Translate',
              ),
              items: Language.languageList()
                  .map<DropdownMenuItem<Language>>((lang) => DropdownMenuItem(
                        value: lang,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              lang.name,
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              lang.flag,
                              style: TextStyle(fontSize: 30),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
