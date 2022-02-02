import 'package:flutter/material.dart';
import 'package:wethepeople/views/homepage.dart';
import 'package:wethepeople/views/tab_view.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    // _firebaseMessaging.getToken().then((token) {
    //   createFCMTokenState(token);
    //   debugPrint('token: $token');
    // });
    // firebase(context);
    // createAudioVideoListState(context);
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    //     overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    Future.delayed(const Duration(
      seconds: 3,
    )).whenComplete(
      () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage())),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: backgroundColor,
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          scale: 2,
        ),
      ),
    );
  }
}
