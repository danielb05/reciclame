import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:reciclame/pages/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final introKey = GlobalKey<_IntroScreenState>();

  void _onIntroEnd(context) {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        value.setBool("isFirstTime", false);
      });
    });

    Navigator.of(context).pushReplacementNamed('/home');
  }

  Widget _buildImage(String assetName, String extension) {
    return Align(
      child: Image.asset('assets/$assetName.$extension', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        value.setBool("isFirstTime", true);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Purpose",
          body:
              "This app has the objective to increase the recycling and save the earth.",
          image: _buildImage('anonymous', "jpg"),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Search",
          body:
              "This app permits you to find a product and know the materials that it is composed.",
          image: _buildImage('finde_logo', "png"),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Location",
          image: _buildImage('map_pin', "png"),
          body: "You can find the nearest bin to recycle.",
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "News",
          body:
              "You can know the most recently news about recycling and environment.",
          decoration: pageDecoration,
          image: _buildImage('news_logo', "png"),
        ),
        PageViewModel(
          title: "Statistics",
          image: _buildImage('charts_logo', 'png'),
          body: "Know your recycling process during this year.",
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
