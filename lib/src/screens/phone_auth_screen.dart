import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:happy_shouket/src/localization/localization_constant.dart';
import 'package:happy_shouket/src/providers/auth.dart';
import 'package:happy_shouket/src/screens/home_screen.dart';
// import 'package:happy_shouket/src/screens/home_screen.dart';
// import 'package:happy_shouket/src/widgets/authservice.dart';
import 'package:happy_shouket/src/widgets/clip_shape.dart';
import 'package:happy_shouket/src/widgets/customappbar.dart';
import 'package:happy_shouket/src/widgets/responsive_ui.dart';
import 'package:provider/provider.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class MobileAuthScreen extends StatefulWidget {
  static const String routeName = 'mobileauth_screen';

  @override
  _MobileAuthScreen createState() => _MobileAuthScreen();
}

class _MobileAuthScreen extends State<MobileAuthScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  // final TextEditingController _mobileController = TextEditingController();
  // final TextEditingController _smsController = TextEditingController();

  String mobileNo, verificationId, smsCode;

  bool codeSent = false;

  bool checkBoxValue = false;
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    return returnMobileAuthScreen();
  }

  Widget returnMobileAuthScreen() {
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
                Container(margin: EdgeInsets.only(bottom: 10.0)),
                signinButton(),
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
                        fontWeight: FontWeight.w500,
                        fontSize: _large ? 18 : (_medium ? 25 : 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: _height / 60.0),
            phoneTextFormField(),
            SizedBox(height: _height / 60.0),
            codeSent ? otpForm() : Container(),
            // button(),
            // verifyButton(),

            SizedBox(height: _height / 60.0),
          ],
        ),
      ),
    );
  }

  Widget phoneTextFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsetsDirectional.only(start: 10.0),
          child: Icon(Icons.phone, color: Colors.orange[200], size: 20),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.lightGreenAccent, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.lightGreenAccent, width: 3.0),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        hintText: getTranslated(context, "mobile_number"),
      ),
      onChanged: (val) {
        setState(() {
          this.mobileNo = val;
        });
      },
      // validator: (value) {
      //   if (value.isEmpty) {
      //     return getTranslated(context, "valid_mobile");
      //   }
      // },
    );
  }

  Widget otpForm() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsetsDirectional.only(start: 10.0),
          child: Icon(Icons.message, color: Colors.orange[200], size: 20),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.lightGreenAccent, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.lightGreenAccent, width: 3.0),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        hintText: getTranslated(context, "otp"),
      ),
      onChanged: (val) {
        setState(() {
          this.smsCode = val;
        });
      },
    );
  }

  Widget signinButton() {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Container(
        margin: EdgeInsets.only(top: 40, bottom: 5),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: RaisedButton(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0)),
            color: Colors.blue,
            onPressed: () async {
              codeSent
                  ? auth.signInWithOTP(smsCode, verificationId, context)
                  : verifyMobileNumber(mobileNo);
            },
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
              child: Center(
                child: codeSent
                    ? Text(
                        getTranslated(context, "login_buttontext"),
                        style: TextStyle(
                          fontSize: _large ? 14 : (_medium ? 12 : 10),
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : Text(
                        getTranslated(context, "verify"),
                        style: TextStyle(
                          fontSize: _large ? 16 : (_medium ? 12 : 10),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              ),
            ),
          ),
        ));
  }

  Future<void> verifyMobileNumber(mobileNo) async {
    final auth = Provider.of<AuthBase>(context, listen: false);
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      auth.signIn(authResult);
    };

    final PhoneVerificationFailed verificationfailed =
        (FirebaseAuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: mobileNo,
        timeout: const Duration(seconds: 120),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}
