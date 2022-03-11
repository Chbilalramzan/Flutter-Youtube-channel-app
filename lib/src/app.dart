// @dart=2.9

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:happy_shouket/src/localization/localization_constant.dart';
import 'package:happy_shouket/src/providers/analytics.dart';
import 'package:happy_shouket/src/providers/auth.dart';
// import 'package:happy_shouket/src/providers/locator.dart';
import 'package:happy_shouket/src/screens/about_us.dart';
import 'package:happy_shouket/src/screens/admin_main.dart';
import 'package:happy_shouket/src/screens/admin_menu_content.dart';
import 'package:happy_shouket/src/screens/feedback_screen.dart';
import 'package:happy_shouket/src/screens/feedback_table.dart';
import 'package:happy_shouket/src/screens/home_screen.dart';
import 'package:happy_shouket/src/screens/intervention_rating.dart';
import 'package:happy_shouket/src/screens/login_screen.dart';
import 'package:happy_shouket/src/sessions_collection/session_eight/sess_eight_feedback.dart';
import 'package:happy_shouket/src/sessions_collection/session_eight/sess_eight_positive.dart';
import 'package:happy_shouket/src/sessions_collection/session_eight/sess_eight_psychoedu.dart';
import 'package:happy_shouket/src/sessions_collection/session_eight/sess_eight_social.dart';
import 'package:happy_shouket/src/sessions_collection/session_eight/sess_eight_spiritual.dart';
import 'package:happy_shouket/src/sessions_collection/session_eight/session_eight_screen.dart';
import 'package:happy_shouket/src/sessions_collection/session_five/sess_five_feedback.dart';
import 'package:happy_shouket/src/sessions_collection/session_five/sess_five_positive.dart';
import 'package:happy_shouket/src/sessions_collection/session_five/sess_five_psychoedu.dart';
import 'package:happy_shouket/src/sessions_collection/session_five/sess_five_social.dart';
import 'package:happy_shouket/src/sessions_collection/session_five/sess_five_spiritual.dart';
import 'package:happy_shouket/src/sessions_collection/session_five/session_five_screen.dart';
import 'package:happy_shouket/src/sessions_collection/session_four/sess_four_positive.dart';
import 'package:happy_shouket/src/sessions_collection/session_four/sess_four_psychoedu.dart';
import 'package:happy_shouket/src/sessions_collection/session_four/sess_four_social.dart';
import 'package:happy_shouket/src/sessions_collection/session_four/sess_four_spiritual.dart';
import 'package:happy_shouket/src/sessions_collection/session_four/session_four_feedback.dart';
import 'package:happy_shouket/src/sessions_collection/session_four/session_four_screen.dart';
import 'package:happy_shouket/src/sessions_collection/session_one/rating_pospsyc.dart';
import 'package:happy_shouket/src/sessions_collection/session_one/session1_social_screen.dart';
import 'package:happy_shouket/src/sessions_collection/session_one/session1_spiritual_screen.dart';
import 'package:happy_shouket/src/sessions_collection/session_seven/sess_seven_feedback.dart';
import 'package:happy_shouket/src/sessions_collection/session_seven/sess_seven_positive.dart';
import 'package:happy_shouket/src/sessions_collection/session_seven/sess_seven_psychoedu.dart';
import 'package:happy_shouket/src/sessions_collection/session_seven/sess_seven_social.dart';
import 'package:happy_shouket/src/sessions_collection/session_seven/sess_seven_spiritual.dart';
import 'package:happy_shouket/src/sessions_collection/session_seven/session_seven_screen.dart';
import 'package:happy_shouket/src/sessions_collection/session_six/sess_six_feedback.dart';
import 'package:happy_shouket/src/sessions_collection/session_six/sess_six_positive.dart';
import 'package:happy_shouket/src/sessions_collection/session_six/sess_six_psychoedu.dart';
import 'package:happy_shouket/src/sessions_collection/session_six/sess_six_social.dart';
import 'package:happy_shouket/src/sessions_collection/session_six/sess_six_spiritual.dart';
import 'package:happy_shouket/src/sessions_collection/session_six/session_six_screen.dart';
import 'package:happy_shouket/src/sessions_collection/session_three/session_three_feedback.dart';
import 'package:happy_shouket/src/sessions_collection/session_three/session_three_positive.dart';
import 'package:happy_shouket/src/sessions_collection/session_three/session_three_psychoedu.dart';
import 'package:happy_shouket/src/sessions_collection/session_three/session_three_screen.dart';
import 'package:happy_shouket/src/sessions_collection/session_three/session_three_social.dart';
import 'package:happy_shouket/src/sessions_collection/session_three/session_three_spiritual.dart';
import 'package:happy_shouket/src/sessions_collection/session_two/session_two_feedback.dart';
import 'package:happy_shouket/src/sessions_collection/session_two/session_two_pos.dart';
import 'package:happy_shouket/src/sessions_collection/session_two/session_two_psychoedu.dart';
import 'package:happy_shouket/src/sessions_collection/session_two/session_two_social.dart';
import 'package:happy_shouket/src/sessions_collection/session_two/session_two_spiritual.dart';
import 'sessions_collection/session_one/main_menu.dart';
import 'package:happy_shouket/src/screens/mobile_login_screen.dart';
import 'package:happy_shouket/src/screens/mobile_signup.dart';
import 'package:happy_shouket/src/screens/phone_auth_screen.dart';
import 'package:happy_shouket/src/screens/positive_psycho.dart';
import 'package:happy_shouket/src/widgets/landing_page.dart';
import 'sessions_collection/session_one/session1_pospsycho_screen.dart';
import 'sessions_collection/session_one/session1_psychoedu_screen.dart';
import 'sessions_collection/session_two/sessions_two_screen.dart';
import 'package:happy_shouket/src/screens/signup_screen.dart';
import 'package:happy_shouket/src/screens/splashscreen.dart';
import 'package:happy_shouket/src/screens/tabs_screen.dart';
import 'package:happy_shouket/src/screens/test_video_player.dart';
import 'package:happy_shouket/src/localization/translator_localization.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType();
    state.setLocale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;
  Locale _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  // Define an async function to initialize FlutterFire
  Future<void> initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => setState(() {
          this._locale = locale;
        }));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if (_error) {
      return Center(
        child: Text('Could not load app'),
      );
    }

    // Show a loader until FlutterFire is initialized
    if ((!_initialized) && (_locale == null)) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return MultiProvider(
        providers: [
          Provider<AuthBase>(create: (context) => Auth()),
        ],
        child: MaterialApp(
          title: 'Happy Shouket',
          theme: ThemeData(
            primaryColor: Color(0xFF19c916),
            accentColor: Colors.amber,
            canvasColor: Color.fromRGBO(255, 254, 229, 1),
            fontFamily: 'Raleway',
            textTheme: ThemeData.light().textTheme.copyWith(
                  bodyText1: TextStyle(
                    color: Color.fromRGBO(50, 100, 100, 1),
                  ),
                  headline1: TextStyle(
                    fontSize: 24,
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.bold,
                  ),
                ),
          ),
          navigatorObservers: <NavigatorObserver>[
            AnalyticsService().getAnalyticsObserver(),
          ],
          locale: _locale,
          supportedLocales: [Locale('en', 'AU'), Locale('ur', 'PK')],
          localizationsDelegates: [
            TranslatorLocalization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (deviceLocale, supportedLocates) {
            for (var locale in supportedLocates) {
              if (locale.languageCode == deviceLocale.languageCode &&
                  locale.countryCode == deviceLocale.countryCode) {
                return deviceLocale;
              }
            }
            return supportedLocates.first;
          },
          debugShowCheckedModeBanner: false,
          home: LandingPage(),
          routes: {
            AboutUsScreen.routeName: (context) => AboutUsScreen(),
            AdminMainScreen.routeName: (context) => AdminMainScreen(),
            AdminMenuContents.routeName: (context) => AdminMenuContents(),
            FeedbackScreen.routeName: (context) => FeedbackScreen(),
            FeedbackData.routeName: (context) => FeedbackData(),
            HomeScreen.routeName: (context) => HomeScreen(),
            LandingPage.routeName: (context) => LandingPage(),
            LoginScreen.routeName: (context) => LoginScreen(),
            MenuPage.routeName: (context) => MenuPage(),
            MobileAuthScreen.routeName: (context) => MobileAuthScreen(),
            MobileLoginScreen.routeName: (context) => MobileLoginScreen(),
            MobileSignUpScreen.routeName: (context) => MobileSignUpScreen(),
            PositivePsychoScreen.routeName: (context) => PositivePsychoScreen(),
            PosRatingScreen.routeName: (context) => PosRatingScreen(),
            EduRatingScreen.routeName: (context) => EduRatingScreen(),
            SessionOneEduItems.routeName: (context) => SessionOneEduItems(),
            SessionOnePosItems.routeName: (context) => SessionOnePosItems(),
            SessionOneSocial.routeName: (context) => SessionOneSocial(),
            SessionOneSpiritual.routeName: (context) => SessionOneSpiritual(),
            SessionTwoFeedbackScreen.routeName: (context) =>
                SessionTwoFeedbackScreen(),
            SessionTwoScreen.routeName: (context) => SessionTwoScreen(),
            SessionTwoPos.routeName: (context) => SessionTwoPos(),
            SessionTwoPsycho.routeName: (context) => SessionTwoPsycho(),
            SessionTwoSocial.routeName: (context) => SessionTwoSocial(),
            SessionTwoSpiritual.routeName: (context) => SessionTwoSpiritual(),
            SessionThreePosPsycho.routeName: (context) =>
                SessionThreePosPsycho(),
            SessionThreeScreen.routeName: (context) => SessionThreeScreen(),
            SessionThreeSocial.routeName: (context) => SessionThreeSocial(),
            SessionThreePsycho.routeName: (context) => SessionThreePsycho(),
            SessionThreeSpritual.routeName: (context) => SessionThreePsycho(),
            SessionThreeFeedbackScreen.routeName: (context) =>
                SessionThreeFeedbackScreen(),
            SessionFourScreen.routeName: (context) => SessionFourScreen(),
            SessionFourFeedbackScreen.routeName: (context) =>
                SessionFourFeedbackScreen(),
            SessionFourPosPsycho.routeName: (context) => SessionFourPosPsycho(),
            SessionFourPsychoEdu.routeName: (context) => SessionFourPsychoEdu(),
            SessionFourSocial.routeName: (context) => SessionFourSocial(),
            SessionFourSpiritual.routeName: (context) => SessionFiveSpiritual(),
            SessionFiveScreen.routeName: (context) => SessionFiveScreen(),
            SessionFiveFeedbackScreen.routeName: (context) =>
                SessionFiveFeedbackScreen(),
            SessionFiveSocial.routeName: (context) => SessionFiveSocial(),
            SessionFiveSpiritual.routeName: (context) => SessionFiveSpiritual(),
            SessionFivePosPsycho.routeName: (context) => SessionFivePosPsycho(),
            SessionFivePsychoedu.routeName: (context) => SessionFivePsychoedu(),
            SessionSixScreen.routeName: (context) => SessionSixScreen(),
            SessionSixSocial.routeName: (context) => SessionSixSocial(),
            SessionSixFeedbackScreen.routeName: (context) =>
                SessionSixFeedbackScreen(),
            SessionSixPsychoedu.routeName: (context) => SessionSixPsychoedu(),
            SessionSixSpiritual.routeName: (context) => SessionSixSpiritual(),
            SessionSixPosPsycho.routeName: (context) => SessionSixPosPsycho(),
            SessionSevenScreen.routeName: (context) => SessionSevenScreen(),
            SessionSevenFeedbackScreen.routeName: (context) =>
                SessionSevenFeedbackScreen(),
            SessionSevenPsychoedu.routeName: (context) =>
                SessionSevenPsychoedu(),
            SessionSevenPosPsycho.routeName: (context) =>
                SessionSevenPosPsycho(),
            SessionSevenSocial.routeName: (context) => SessionSevenSocial(),
            SessionSevenSpiritual.routeName: (context) =>
                SessionSevenSpiritual(),
            SessionEightScreen.routeName: (context) => SessionEightScreen(),
            SessionEightFeedbackScreen.routeName: (context) =>
                SessionEightFeedbackScreen(),
            SessionEightPsychoedu.routeName: (context) =>
                SessionEightPsychoedu(),
            SessionEightPosPsycho.routeName: (context) =>
                SessionEightPosPsycho(),
            SessionEightSocial.routeName: (context) => SessionEightSocial(),
            SessionEightSpiritual.routeName: (context) =>
                SessionEightSpiritual(),
            SignUpScreen.routeName: (context) => SignUpScreen(),
            SplashScreen.routeName: (context) => SplashScreen(),
            TabsScreen.routeName: (context) => TabsScreen(),
            TestVideoScreen.routeName: (context) => TestVideoScreen(),
          },
        ),
      );
    }
  }
}
