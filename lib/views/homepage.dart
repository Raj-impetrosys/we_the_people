import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_media_notification/flutter_media_notification.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:media_notification/media_notification.dart';
// import 'package:music_visualizer/music_visualizer.dart';
import 'package:wethepeople/controllers/audio_player_controller.dart';
import 'package:wethepeople/controllers/music_visualizer.dart';
import 'package:wethepeople/globals/app_constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

StreamController<bool> streamController = StreamController<bool>.broadcast();

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Stream stream = streamController.stream;
  Animation animation;
  AnimationController animationController;
  AudioPlayerController audioPlayerController = AudioPlayerController();

  double volume = 60.0;

  animate() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    animation = Tween(begin: 0, end: 1).animate(animationController)
      ..addListener(() {
        setState(() {});
      });
    controlPlayPause();
    // Constants.isPlaying
    //     ? animationController.forward()
    //     : animationController.reverse();
    // streamController.add(!Constants.isPlaying);
  }

  controlPlayPause() {
    Constants.isPlaying
        ? animationController.forward()
        : animationController.reverse();
    if (mounted) streamController.add(Constants.isPlaying);
  }

  setAndroidNotification() {
    MediaNotification.showNotification(
        title: Constants.projectName, author: "", isPlaying: Constants.isPlaying
        //  imageUrl: Constants.logoUrl,
        );
    MediaNotification.setListener('play', () {
      audioPlayerController.play();
      if (mounted) {
        setState(() => Constants.isPlaying = true);
        controlPlayPause();
      } else {
        Constants.isPlaying = true;
      }
    });

    MediaNotification.setListener('pause', () {
      audioPlayerController.stop();
      if (mounted) {
        setState(() => Constants.isPlaying = false);
        controlPlayPause();
      } else {
        Constants.isPlaying = false;
      }
    });
  }

  // audioPlayerHandler() {
  //   audioPlayerController.player.onNotificationPlayerStateChanged
  //       .listen((event) {
  //     switch (event) {
  //       case PlayerState.STOPPED:
  //         setState(() {
  //           Constants.isPlaying = false;
  //         });
  //         break;
  //       case PlayerState.PLAYING:
  //         setState(() {
  //           Constants.isPlaying = true;
  //         });
  //         break;
  //       case PlayerState.PAUSED:
  //         setState(() {
  //           Constants.isPlaying = false;
  //         });
  //         break;
  //       case PlayerState.COMPLETED:
  //         setState(() {
  //           Constants.isPlaying = false;
  //         });
  //         break;
  //     }
  //   });
  // }

  @override
  void initState() {
    audioPlayerController.init();
    animate();
    setAndroidNotification();
    // audioPlayerHandler();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Future.delayed(const Duration(seconds: 1)).whenComplete(() {
      streamController.add(Constants.isPlaying);
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final List<Color> colors = [
      Colors.red[900],
      Colors.green[900],
      Colors.blue[900],
      Colors.brown[900]
    ];

    final List<int> duration = [900, 700, 600, 800, 500];
    return Scaffold(
      // appBar: AppBar(
      //   actions: [
      //     IconButton(onPressed: () {

      //     }, icon: const Icon(Icons.notification_add))
      //   ],
      // ),
      // bottomNavigationBar: Row(
      //   mainAxisSize: MainAxisSize.max,
      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //   children: [
      //     ElevatedButton(
      //         style: ButtonStyle(
      //             padding: MaterialStateProperty.all(const EdgeInsets.all(25))),
      //         onPressed: () {
      //           showModalBottomSheet(
      //               isScrollControlled: true,
      //               constraints: BoxConstraints(
      //                 maxHeight: height * 0.8,
      //               ),
      //               context: context,
      //               builder: (context) => const Contact());
      //         },
      //         child: const Text(
      //           "Notification",
      //           style: TextStyle(fontSize: 20),
      //         )),
      //     ElevatedButton(
      //         style: ButtonStyle(
      //             padding: MaterialStateProperty.all(const EdgeInsets.all(25))),
      //         onPressed: () {
      //           showModalBottomSheet(
      //               isScrollControlled: true,
      //               constraints: BoxConstraints(
      //                 maxHeight: height * 0.8,
      //               ),
      //               context: context,
      //               builder: (context) => const Contact());
      //         },
      //         child: const Text(
      //           "Contact info",
      //           style: TextStyle(fontSize: 20),
      //         )),
      //   ],
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Image.asset("assets/images/logo_1024_trans.png"),
          ),
          SizedBox(
            height: 60,
            child: MusicVisualizer(
              curve: Curves.easeInCubic,
              barCount: 30,
              colors: colors,
              duration: duration,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Text("Now Playing WTP  93.5 FM"),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 2,
                    width: 200,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    Constants.projectName,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              controls(),
            ],
          ),
          volumeController()
        ],
      ),
    );
  }

  NeumorphicStyle neumorphicStyle = const NeumorphicStyle(
      shape: NeumorphicShape.concave,
      boxShape: NeumorphicBoxShape.circle(),
      depth: 8,
      lightSource: LightSource.topLeft,
      color: Colors.white);
  Color iconColors = Colors.black;

  controls() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Neumorphic(
          //     padding: const EdgeInsets.all(5),
          //     style: neumorphicStyle,
          //     child: const Icon(Icons.skip_previous)),
          // const SizedBox(
          //   width: 10,
          // ),
          GestureDetector(
            onTap: () {
              Constants.isPlaying
                  ? animationController.reverse()
                  : animationController.forward();
              Constants.isPlaying
                  ? audioPlayerController.stop()
                  : audioPlayerController.play();

              // if (Constants.isPlaying) {
              //   animationController!.reverse();
              //   audioPlayerController!.stop();
              // } else {
              //   audioPlayerController!.stop();
              //   audioPlayerController!.play();
              // }
              Constants.isPlaying = !Constants.isPlaying;
              streamController.add(Constants.isPlaying);
            },
            child: Neumorphic(
                padding: const EdgeInsets.all(10),
                style: neumorphicStyle,
                child: AnimatedIcon(
                  icon: AnimatedIcons.play_pause,
                  progress: animationController,
                  color: iconColors,
                  size: 30,
                )),
          ),
          // const SizedBox(
          //   width: 10,
          // ),
          // Neumorphic(
          //     padding: const EdgeInsets.all(5),
          //     style: neumorphicStyle,
          //     child: const Icon(Icons.skip_next)),
        ],
      );

  volumeController() => Center(
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(500)),
          elevation: 5,
          color: Colors.black,
          child: SizedBox(
            height: 50,
            // width: width * 0.9,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        (volume > 9) ? volume = volume - 10 : volume = 0;
                      });
                      audioPlayerController.setVolume(volume: volume/100);
                    },
                    child: Icon(
                      (volume == 0) ? Icons.volume_off : Icons.volume_down,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  Expanded(
                    child: SliderTheme(
                      data: const SliderThemeData(trackHeight: 0.5),
                      child: Slider(
                        onChanged: (value) {
                          setState(() {
                            volume = value;
                          });
                          audioPlayerController.setVolume(volume: value / 100);
                        },
                        min: 0,
                        max: 100,
                        divisions: 100,
                        value: volume,
                        activeColor: Colors.white,
                        inactiveColor: Colors.white70,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        (volume < 91) ? volume = volume + 10 : volume = 100;
                      });
                      audioPlayerController.setVolume(volume: volume/100);
                    },
                    child: const Icon(
                      Icons.volume_up,
                      color: Colors.white,
                      size: 30,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
