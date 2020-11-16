import 'package:flutter/material.dart';
import 'package:reciclame/constants.dart';
import 'package:reciclame/pages/Home.dart';
import 'package:reciclame/pages/ItemDetail.dart';
import 'package:reciclame/pages/Login.dart';
import 'package:reciclame/pages/Opening.dart';
import 'package:reciclame/pages/Settings.dart';
import 'file:///C:/Users/francesc/Desktop/reciclame/lib/pages/SignUp/SignUp.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'localization/demo_localization.dart';
import 'localization/language_constants.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(newLocale);
  }

  static String getLang(BuildContext context){
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    return state.getLang();
  }

  static Locale getLocale(BuildContext context){
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    return state.getLocate();
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Locale _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  getLocate(){
    return _locale;
  }

  getLang(){
    return _locale.toString();
  }


  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        locale: _locale,
        supportedLocales: [
          Locale("en", "US"),
          Locale("es", "ES"),
        ],
        localizationsDelegates: [
          DemoLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        debugShowCheckedModeBanner: false,
        initialRoute: '/opening',
        routes: {'/home': (context) => Home(),
                  '/login': (context) => Login(),
                  '/opening': (context) => Opening(),
                  '/settings': (context) => Settings(),
                  '/signup': (context) => SignUp(),
                  '/item':(context)=> ItemDetail(ModalRoute.of(context).settings.arguments)
        },
        theme: ThemeData(
            scaffoldBackgroundColor: kBackgroundColor,
            primaryColor: kPrimaryColor,
            textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
            visualDensity: VisualDensity.adaptivePlatformDensity)
    );
  }
}
