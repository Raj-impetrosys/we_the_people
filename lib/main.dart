import 'package:audio_service/audio_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:wethepeople/controllers/audio_player_controller.dart';
import 'package:wethepeople/views/splash.dart';

AudioHandler audioHandler;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // audioHandler = await AudioService.init(
  //   builder: () => AudioPlayerController(),
  //   config: const AudioServiceConfig(
  //     androidNotificationChannelId: 'com.wethepeople.broadlink.channel.audio',
  //     androidNotificationChannelName: 'Audio playback',
  //     androidNotificationOngoing: true,
  //   ),
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'We The People',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          // textTheme: GoogleFonts.aBeeZeeTextTheme(),
      ),
      home: const Splash(),
    );
  }
}
