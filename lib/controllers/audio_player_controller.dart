// import 'package:just_audio/just_audio.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
// import 'package:media_notificationx/media_notificationx.dart';
import 'package:wethepeople/globals/app_constants.dart';
import 'package:wethepeople/services/api/audio_video_url_api.dart';

class AudioPlayerController {
  // final player = AudioPlayer();
  Duration? duration = Duration.zero;
  String? liveAudioUrl;

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

  final AudioPlayer player = AudioPlayer(
      mode: PlayerMode.MEDIA_PLAYER, playerId: Constants.projectName);

  init() async {
    createAudioVideoListState().then((value) {
      liveAudioUrl = value.data!['audio']['file'];
    }).whenComplete(() async {
      // result = await audioPlayer.play(iveAudioUrl!);
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
    await player.play(liveAudioUrl!);
  }

  pause() async {
    await player.pause();
  }

  stop() async {
    await player.stop();
  }

  setVolume({required double? volume}) async {
    await player.setVolume(volume!);
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
}
