import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

class AlertService extends GetxService {
  final AudioPlayer player = AudioPlayer();

  void playSound() async {
    // Play the alert sound file at the current volume
    // final player = AudioCache();

    // player.play(soundFile.value);

    await player.play(AssetSource('alert_sound.mp3'));
  }
}
