import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

class PronunciationService {
  PronunciationService._();
  static final FlutterTts _tts = FlutterTts();
  static bool _isInitialized = false;
  static Future<void> init() async {
    if (_isInitialized) return;
    try {
      await _tts.setLanguage('ja-JP');
      await _tts.setSpeechRate(0.38);
      await _tts.setVolume(1.0);
      await _tts.setPitch(1.0);
      _isInitialized = true;
      debugPrint('PronunciationService: initialized ✓');
    } catch (e) {
      debugPrint('PronunciationService init error: $e');
    }
  }

  static Future<void> speak(String text) async {
    if (!_isInitialized) await init();
    try {
      await _tts.speak(text);
    } catch (e) {
      debugPrint('PronunciationService speak error: $e');
    }
  }

  static Future<void> stop() async {
    try {
      await _tts.stop();
    } catch (e) {
      debugPrint('PronunciationService stop error: $e');
    }
  }
}
