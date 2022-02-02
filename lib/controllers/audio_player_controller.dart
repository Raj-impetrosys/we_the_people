import 'package:just_audio/just_audio.dart';
import 'package:wethepeople/services/api/audio_video_url_api.dart';

class AudioPlayerController {
  final player = AudioPlayer();
  Duration? duration = Duration.zero;
  String? liveAudioUrl;

  init() async {
    createAudioVideoListState().then((value) {
      liveAudioUrl = value.data!['audio']['file'];
    }).whenComplete(() async {
      duration = await player.setUrl(liveAudioUrl!);
    });
  }

  play() async {
    await player.play();
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
}
