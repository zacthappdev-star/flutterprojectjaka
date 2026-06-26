import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:ppkd_b6/data/data_hiragana.dart';
import 'package:ppkd_b6/data/data_katakana.dart';
import 'package:ppkd_b6/gen/strings.g.dart';

class AudioService {
  static final AudioPlayer _audioPlayer = AudioPlayer();
  static final FlutterTts _tts = FlutterTts();
  static bool _ttsInitialized = false;
  static Future<void> _initTts() async {
    if (_ttsInitialized) return;
    try {
      await _tts.setLanguage('ja-JP');
      await _tts.setSpeechRate(0.38);
      await _tts.setVolume(1.0);
      await _tts.setPitch(1.0);
      _ttsInitialized = true;
    } catch (e) {
      debugPrint('AudioService TTS initialization failed: $e');
    }
  }

  static String getCharFromAudioPath(String path) {
    for (var g in HiraganaData.groups) {
      for (var c in g.characters) {
        if (c.effectiveAudioPath == path) {
          return c.character;
        }
      }
    }
    for (var g in KatakanaData.groups) {
      for (var c in g.characters) {
        if (c.effectiveAudioPath == path) {
          return c.character;
        }
      }
    }
    return '';
  }

  /// Resolves the audio path for a given character string.
  static String getAudioPathForChar(String char) {
    for (var g in HiraganaData.groups) {
      for (var c in g.characters) {
        if (c.character == char) {
          return c.effectiveAudioPath;
        }
      }
    }
    for (var g in KatakanaData.groups) {
      for (var c in g.characters) {
        if (c.character == char) {
          return c.effectiveAudioPath;
        }
      }
    }
    return '';
  }

  static Future<bool> playAudio(String path) async {
    try {
      await _audioPlayer.stop();
      await _tts.stop();
      String char = '';
      if (!path.contains('/') && !path.endsWith('.mp3')) {
        char = path;
      } else {
        char = getCharFromAudioPath(path);
      }

      if (char.isNotEmpty) {
        await _initTts();
        await _tts.speak(char);
        return true;
      }
      try {
        await rootBundle.load('assets/$path');
      } catch (e) {
        return false;
      }
      await _audioPlayer.play(AssetSource(path));
      return true;
    } catch (e) {
      try {
        await rootBundle.load('assets/$path');
        await _audioPlayer.play(AssetSource(path));
        return true;
      } catch (_) {
        return false;
      }
    }
  }

  static Future<void> playAudioWithFeedback(
    BuildContext context,
    String path,
  ) async {
    final success = await playAudio(path);
    if (!success && context.mounted) {
      // Use i18n string from context
      final msg = Translations.of(context).errors.audioNotAvailable;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg), duration: Duration(seconds: 2)),
      );
    }
  }

  static Future<void> stopAudio() async {
    try {
      await _audioPlayer.stop();
      await _tts.stop();
    } catch (e) {
      // ignore
    }
  }

  /// Pauses any currently playing audio/TTS.
  static Future<void> pauseAudio() async {
    try {
      await _audioPlayer.pause();
      await _tts.stop();
    } catch (e) {
      // ignore
    }
  }
}
