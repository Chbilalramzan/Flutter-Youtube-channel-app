import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:happy_shouket/src/localization/localization_constant.dart';
import 'package:happy_shouket/src/screens/home_screen.dart';
import 'package:happy_shouket/src/screens/mobile_signup.dart';
import 'package:happy_shouket/src/widgets/clip_shape.dart';
import 'package:happy_shouket/src/widgets/customappbar.dart';
import 'package:happy_shouket/src/widgets/responsive_ui.dart';
import 'package:happy_shouket/src/widgets/textformfield.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class MobileLoginScreen extends StatefulWidget {
  MobileLoginScreen({Key key}) : super(key: key);

  static const String routeName = 'mobilesignin_screen';

  @override
  _MobileLoginScreenState createState() => _MobileLoginScreenState();
}

class _MobileLoginScreenState extends State<MobileLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formKeyOTP = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  final TextEditingController _mobileController = new TextEditingController();
  final TextEditingController otpController = new TextEditingController();

  bool checkBoxValue = false;
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;

  var isLoading = false;
  var isResend = false;
  var isLoginScreen = true;
  var isOTPScreen = false;
  var verificationCode = '';

  @override
  void initState() {
    if (_auth.currentUser != null) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => HomeScreen(),
        ),
        (route) => false,
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    return isOTPScreen ? returnOTPScreen() : returnMobileLoginScreen();
  }

  Widget returnMobileLoginScreen() {
    return Material(
      child: Scaffold(
        key: _scaffoldKey,
        body: Container(
          height: _height,
          width: _width,
          margin: EdgeInsets.only(bottom: 5),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Opacity(opacity: 0.88, child: CustomAppBar()),
                ClipShape(),
                form(),
                SizedBox(
                  height: _height / 35,
                ),
                button(),
                Container(margin: EdgeInsets.only(bottom: 40.0)),
                signUpTextRow(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget form() {
    return Container(
      margin: EdgeInsets.only(
          left: _width / 12.0, right: _width / 12.0, top: _height / 20.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            phoneTextFormField(),
            SizedBox(height: _height / 60.0),
          ],
        ),
      ),
    );
  }

  Widget phoneTextFormField() {
    return CustomTextField(
      enabled: !isLoading,
      textEditingController: _mobileController,
      keyboardType: TextInputType.number,
      icon: Icons.phone,
      hint: getTranslated(context, "mobile_number"),
      validator: (value) {
        if (value.isEmpty) {
          return getTranslated(context, "valid_mobile");
        }
      },
    );
  }

  Widget button() {
    return Container(
      margin: EdgeInsets.only(top: 40, bottom: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: !isLoading
            ? new ElevatedButton(
                onPressed: () async {
                  if (!isLoading) {
                    if (_formKey.currentState.validate()) {
                      displaySnackBar('Please wait...');
                      await login();
                    }
                  }
                },
                child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 15.0,
                    ),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                            child: Text(
                          "Sign In",
                          textAlign: TextAlign.center,
                        )),
                      ],
                    )),
              )
            : CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColor,
              ),
      ),
    );
  }

  Widget signUpTextRow(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: _height / 120.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            getTranslated(context, "no_useraccount"),
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: _large ? 19 : (_medium ? 12 : 10)),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              // Navigator.pushNamed(context, PositivePsychoScreen.routeName);
              Navigator.pushNamed(context, MobileSignUpScreen.routeName);
              print("Routing to Sign up screen");
            },
            child: Text(
              getTranslated(context, "signup_text"),
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

  Widget returnOTPScreen() {
    return Material(
      child: Scaffold(
        key: _scaffoldKey,
        body: Container(
          height: _height,
          width: _width,
          margin: EdgeInsets.only(bottom: 5),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Opacity(opacity: 0.88, child: CustomAppBar()),
                ClipShape(),
                otpForm(),
                SizedBox(
                  height: _height / 35,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget otpForm() {
    return Container(
      margin: EdgeInsets.only(
          left: _width / 12.0, right: _width / 12.0, top: _height / 20.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    child: Text(
                        !isLoading
                            ? "Enter OTP from SMS"
                            : "Sending OTP code SMS",
                        textAlign: TextAlign.center))),
            !isLoading
                ? Container(
                    child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    child: TextFormField(
                      enabled: !isLoading,
                      controller: otpController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      initialValue: null,
                      autofocus: true,
                      decoration: InputDecoration(
                          labelText: 'OTP',
                          labelStyle: TextStyle(color: Colors.black)),
                      // ignore: missing_return
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter OTP';
                        }
                      },
                    ),
                  ))
                : Container(),
            !isLoading
                ? Container(
                    margin: EdgeInsets.only(top: 40, bottom: 5),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: new ElevatedButton(
                          onPressed: () async {
                            if (_formKeyOTP.currentState.validate()) {
                              // If the form is valid, we want to show a loading Snackbar
                              // If the form is valid, we want to do firebase signup...
                              setState(() {
                                isResend = false;
                                isLoading = true;
                              });
                              try {
                                await _auth
                                    .signInWithCredential(
                                        PhoneAuthProvider.credential(
                                            verificationId: verificationCode,
                                            smsCode:
                                                otpController.text.toString()))
                                    .then((user) async => {
                                          //sign in was success
                                          if (user != null)
                                            {
                                              //store registration details in firestore database
                                              setState(() {
                                                isLoading = false;
                                                isResend = false;
                                              }),
                                              Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          HomeScreen(),
                                                ),
                                                (route) => false,
                                              )
                                            }
                                        })
                                    .catchError((error) => {
                                          setState(() {
                                            isLoading = false;
                                            isResend = true;
                                          }),
                                        });
                                setState(() {
                                  isLoading = true;
                                });
                              } catch (e) {
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            }
                          },
                          child: new Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 15.0,
                              horizontal: 15.0,
                            ),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Expanded(
                                  child: Text(
                                    "Submit",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            CircularProgressIndicator(
                              backgroundColor: Theme.of(context).primaryColor,
                            )
                          ].where((c) => c != null).toList(),
                        )
                      ]),
            isResend
                ? Container(
                    margin: EdgeInsets.only(top: 40, bottom: 5),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: new ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              isResend = false;
                              isLoading = true;
                            });
                            await login();
                          },
                          child: new Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 15.0,
                              horizontal: 15.0,
                            ),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Expanded(
                                  child: Text(
                                    "Resend Code",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )))
                : Column()
          ],
        ),
      ),
    );
  }

  displaySnackBar(text) {
    final snackBar = SnackBar(content: Text(text));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  Future login() async {
    setState(() {
      isLoading = true;
    });

    var phoneNumber = '+61 ' + _mobileController.text.trim();

    //first we will check if a user with this cell number exists
    var isValidUser = false;
    var number = _mobileController.text.trim();

    await _firestore
        .collection('users')
        .where('mobilenumber', isEqualTo: number)
        .get()
        .then((result) {
      if (result.docs.length > 0) {
        isValidUser = true;
      }
    });

    if (isValidUser) {
      //ok, we have a valid user, now lets do otp verification
      var verifyPhoneNumber = _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (phoneAuthCredential) {
          //auto code complete (not manually)
          _auth.signInWithCredential(phoneAuthCredential).then((user) async => {
                if (user != null)
                  {
                    //redirect
                    setState(() {
                      isLoading = false;
                      isOTPScreen = false;
                    }),
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => HomeScreen(),
                      ),
                      (route) => false,
                    )
                  }
              });
        },
        verificationFailed: (FirebaseAuthException error) {
          displaySnackBar('Validation error, please try again later');
          setState(() {
            isLoading = false;
          });
        },
        codeSent: (verificationId, [forceResendingToken]) {
          setState(() {
            isLoading = false;
            verificationCode = verificationId;
            isOTPScreen = true;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            isLoading = false;
            verificationCode = verificationId;
          });
        },
        timeout: Duration(seconds: 60),
      );
      await verifyPhoneNumber;
    } else {
      //non valid user
      setState(() {
        isLoading = false;
      });
      displaySnackBar('Number not found, please sign up first');
    }
  }
}
