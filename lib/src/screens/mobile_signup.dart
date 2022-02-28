import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:happy_shouket/src/localization/localization_constant.dart';
import 'package:happy_shouket/src/screens/home_screen.dart';
import '../widgets/responsive_ui.dart';
import '../widgets/customappbar.dart';
import '../widgets/textformfield.dart';
import 'package:happy_shouket/src/widgets/clip_shape.dart';
import '../sessions_collection/session_one/main_menu.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class MobileSignUpScreen extends StatefulWidget {
  static const String routeName = 'mobilesignup_screen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<MobileSignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formKeyOTP = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  var isLoading = false;
  var isResend = false;
  var isSignUp = true;
  var isOTPScreen = false;
  var verificationCode = '';

  // FocusNode myFocusNode;

  bool checkBoxValue = false;
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  int mobile;
  String password;
  String repassword;

  @override
  void initState() {
    super.initState();
    // myFocusNode = FocusNode();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   FocusScope.of(context).requestFocus(myFocusNode);
    // });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _otpController.dispose();
    // myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    return isOTPScreen ? returnOTPScreen() : signupScreen();
  }

  Widget signupScreen() {
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
                acceptTermsTextRow(),
                SizedBox(
                  height: _height / 35,
                ),
                button(),
                //signInTextRow(),
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
            nameTextFormField(),
            SizedBox(height: _height / 60.0),
            phoneTextFormField(),
            SizedBox(height: _height / 60.0),
          ],
        ),
      ),
    );
  }

  Widget nameTextFormField() {
    final node = FocusScope.of(context);
    return CustomTextField(
      enabled: !isLoading,
      textEditingController: _nameController,
      onChanged: TextInputAction.next,
      onEdit: () => node.nextFocus(),
      keyboardType: TextInputType.text,
      icon: Icons.person,
      hint: getTranslated(context, "name"),
      validator: (value) {
        if (value.isEmpty) {
          return getTranslated(context, "name_error");
        }
      },
    );
  }

  Widget phoneTextFormField() {
    final node = FocusScope.of(context);
    return CustomTextField(
      enabled: !isLoading,
      textEditingController: _mobileController,
      keyboardType: TextInputType.number,
      onChanged: TextInputAction.done,
      onSubmit: (_) => node.unfocus(),
      icon: Icons.phone,
      hint: getTranslated(context, "mobile_number"),
      validator: (value) {
        if (value.isEmpty) {
          return getTranslated(context, "valid_mobile");
        }
      },
    );
  }

  Widget acceptTermsTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 100.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Checkbox(
              activeColor: Colors.blue[500],
              value: checkBoxValue,
              onChanged: (bool newValue) {
                setState(() {
                  checkBoxValue = newValue;
                });
              }),
          Text(
            getTranslated(context, "accept_t&cs"),
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: _large ? 20 : (_medium ? 11 : 10)),
          ),
        ],
      ),
    );
  }

  Widget button() {
    return Container(
      margin: EdgeInsets.only(top: 40, bottom: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: RaisedButton(
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          onPressed: () {
            if (isLoading) {
              if (_formKey.currentState.validate()) {
                // If the form is valid, show a loading Snackbar
                setState(() {
                  signUp();
                  isSignUp = false;
                  isOTPScreen = true;
                });
              }
            }
            print("Routing to your account");
          },
          textColor: Colors.black,
          padding: EdgeInsets.all(0.0),
          child: Container(
            alignment: Alignment.center,
//        height: _height / 20,
            width:
                _large ? _width / 4 : (_medium ? _width / 3.75 : _width / 3.5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              gradient: LinearGradient(
                colors: <Color>[Color(0xFFf5e980), Color(0xFF19c916)],
              ),
            ),
            padding: const EdgeInsets.all(12.0),
            child: Text(
              getTranslated(context, "next_button"),
              style: TextStyle(fontSize: _large ? 19 : (_medium ? 12 : 10)),
            ),
          ),
        ),
      ),
    );
  }

  Widget returnOTPScreen() {
    return Material(
      child: Scaffold(
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
        key: _formKeyOTP,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 10.0),
                child: Text(
                    !isLoading ? "Enter OTP from SMS" : "Sending OTP code SMS",
                    textAlign: TextAlign.center),
              ),
            ),
            !isLoading
                ? Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      child: CustomTextField(
                        enabled: !isLoading,
                        textEditingController: _otpController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        initialValue: null,
                        autofocus: true,
                        hint: getTranslated(context, "otp"),
                        validator: (value) {
                          if (value.isEmpty) {
                            return getTranslated(context, "otp_error");
                          }
                        },
                      ),
                    ),
                  )
                : Container(),
            !isLoading
                ? Container(
                    margin: EdgeInsets.only(top: 40, bottom: 5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: ElevatedButton(
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
                                              _otpController.text.toString()))
                                  .then((user) async => {
                                        //sign in was success
                                        if (user != null)
                                          {
                                            //store registration details in firestore database
                                            await _firestore
                                                .collection('users')
                                                .doc(_auth.currentUser.uid)
                                                .set({
                                              'name':
                                                  _nameController.text.trim(),
                                              'mobilenumber':
                                                  _mobileController.text.trim()
                                            }, SetOptions(merge: true)).then(
                                                    (value) => {
                                                          //then move to authorised area
                                                          setState(() {
                                                            isLoading = false;
                                                            isResend = false;
                                                          })
                                                        }),

                                            setState(() {
                                              isLoading = false;
                                              isResend = false;
                                            }),
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        MenuPage(),
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
                                  (getTranslated(context, "submit_button")),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
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
                    ],
                  ),
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
                          await signUp();
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
                                  getTranslated(context, "resend_code"),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : Column()
          ],
        ),
      ),
    );
  }

  Future signUp() async {
    setState(() {
      isLoading = true;
    });
    debugPrint('Petty test 1');
    var phoneNumber = '+61 ' + _mobileController.text.toString();
    debugPrint('Petty test 2');
    var verifyMobileNumber = _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (phoneAuthCredential) {
        debugPrint('Petty test 3');
        //auto code complete (not manually)
        _auth.signInWithCredential(phoneAuthCredential).then((user) async => {
              if (user != null)
                {
                  //store registration details in firestore database
                  await _firestore
                      .collection('users')
                      .doc(_auth.currentUser.uid)
                      .set({
                        'name': _nameController.text.trim(),
                        'mobilenumber': _mobileController.text.trim()
                      }, SetOptions(merge: true))
                      .then((value) => {
                            //then move to authorised area
                            setState(() {
                              isLoading = false;
                              isSignUp = false;
                              isOTPScreen = false;

                              //navigate to is
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      HomeScreen(),
                                ),
                                (route) => false,
                              );
                            })
                          })
                      .catchError((onError) => {
                            debugPrint(
                                'Error saving user to db.' + onError.toString())
                          })
                }
            });
        debugPrint('Petty test 4');
      },
      verificationFailed: (FirebaseAuthException error) {
        debugPrint('Petty test 5' + error.message);
        setState(() {
          isLoading = false;
        });
      },
      codeSent: (verificationId, [forceResendingToken]) {
        debugPrint('Petty test 6');
        setState(() {
          isLoading = false;
          verificationCode = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        debugPrint('Petty test 7');
        setState(() {
          isLoading = false;
          verificationCode = verificationId;
        });
      },
      timeout: Duration(seconds: 60),
    );
    debugPrint('Petty test 7');
    await verifyMobileNumber;
    debugPrint('Petty test 8');
  }
}
