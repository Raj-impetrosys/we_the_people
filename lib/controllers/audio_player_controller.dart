// import 'package:just_audio/just_audio.dart';
import 'package:audio_service/audio_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_notification/flutter_media_notification.dart';
// import 'package:media_notificationx/media_notificationx.dart';
import 'package:wethepeople/globals/app_constants.dart';
import 'package:wethepeople/main.dart';
import 'package:wethepeople/services/api/audio_video_url_api.dart';

class AudioPlayerController {
  // final player = AudioPlayer();
  Duration duration = Duration.zero;
  String liveAudioUrl;
  double volume = 0.60;

  // init() async {
  //   createAudioVideoListState().then((value) {
  //     liveAudioUrl = value.data!['audio']['file'];
  //   }).whenComplete(() async {
  //     duration = await player.setUrl(liveAudioUrl!);
  //   });
  // }

  // play() async {
  //   await player.play();
  // }

  // pause() async {
  //   await player.pause();
  // }

  // stop() async {
  //   await player.stop();
  // }

  // setVolume({required double? volume}) async {
  //   await player.setVolume(volume!);
  // }

  /// audioplayers -------------------------------

  final AudioPlayer player = AudioPlayer(
      mode: PlayerMode.MEDIA_PLAYER, playerId: Constants.projectName);

  init() async {
    createAudioVideoListState().then((value) {
      liveAudioUrl = value.data['audio']['file'];
    }).whenComplete(() async {
      // result = await audioPlayer.play(iveAudioUrl!);
      // Constants.isPlaying? audioPlayerController.play():audioPlayerController.stop();
      Constants.isPlaying? play(): stop();
    });
    setNotification();
    // setAndroidNotification();

    player.onPlayerError.listen((msg) {
      debugPrint('audioPlayer error : $msg');
      pause();
      // if (mounted) {
      //   setState(() => Constants.isPlaying = false);
      // } else {
      Constants.isPlaying = false;
      // }
    });
  }

  play() async {
    int result = await player.play(liveAudioUrl, volume: volume);
    if (result == 1) {
      setAndroidNotification();
    }
  }

  pause() async {
    int result = await player.pause();
    if (result == 1) {
      setAndroidNotification();
    }
  }

  stop() async {
    int result = await player.stop();
    if (result == 1) {
      setAndroidNotification();
    }
  }

  setVolume({@required double volume}) async {
    this.volume = volume;
    await player.setVolume(volume);
  }

  setAndroidNotification() async {
    await MediaNotification.showNotification(
        title: Constants.projectName, isPlaying: Constants.isPlaying);
  }

  setNotification() async {
    // player.notificationService.setNotification()
    await player.notificationService.startHeadlessService();
    await player.notificationService.setNotification(
      title: Constants.projectName,
      imageUrl: Constants.logoUrl,
    );

    await player.notificationService.monitorStateChanges((value) {
      // debugPrint(value.toString());
    });

    player.notificationService.onPlayerCommand.listen((event) {
      print(event);
    });
  }

  ///audio_service -------------------------------------

  // AudioHandler _audioHandler;
  // static MediaItem _item = MediaItem(
  //   id: 'https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3',
  //   album: "Science Friday",
  //   title: "A Salute To Head-Scratching Science",
  //   artist: "Science Friday and WNYC Studios",
  //   duration: const Duration(milliseconds: 5739820),
  //   artUri: Uri.parse(
  //       'https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg'),
  // );

  // init() async {
  //   // _audioHandler = await AudioService.init(
  //   //   builder: () => AudioPlayerController(),
  //   //   config: const AudioServiceConfig(
  //   //     androidNotificationChannelId: 'com.wethepeople.broadlink.channel.audio',
  //   //     androidNotificationChannelName: 'Music playback',
  //   //   ),
  //   // );
  //   createAudioVideoListState().then((value) {
  //     liveAudioUrl = value.data['audio']['file'];
  //     _item = MediaItem(
  //       id: liveAudioUrl,
  //       album: Constants.projectName,
  //       title: Constants.projectName,
  //       // artist: "Science Friday and WNYC Studios",
  //       // duration: const Duration(milliseconds: 5739820),
  //       artUri: Uri.parse(
  //           'https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg'),
  //     );
  //   }).whenComplete(() async {
  //     // result = await audioPlayer.play(iveAudioUrl!);
  //   });
  // }

  // @override
  // Future<void> play() async {
  //   print(liveAudioUrl);
  //   // _audioHandler.playFromUri(Uri.parse(liveAudioUrl));
  //   audioHandler.playMediaItem(_item);
  //   // All 'play' requests from all origins route to here. Implement this
  //   // callback to start playing audio appropriate to your app. e.g. music.
  // }

  // @override
  // Future<void> pause() async {
  //   audioHandler.pause();
  // }

  // @override
  // Future<void> stop() async {
  //   audioHandler.stop();
  // }

  // setVolume({volume}) {
  //   audioHandler.androidAdjustRemoteVolume(AndroidVolumeDirection.raise);
  //   audioHandler.androidSetRemoteVolume(volume);
  // }
}
