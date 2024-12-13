import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

typedef OnWordDetected = void Function(String);

class KlsSpeechToText extends StatefulWidget {
  final OnWordDetected? onWordDetected;

  const KlsSpeechToText({super.key, this.onWordDetected});

  @override
  State<KlsSpeechToText> createState() => _KlsSpeechToTextState();
}

class _KlsSpeechToTextState extends State<KlsSpeechToText> {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  @override
  void dispose() {
    _speechToText.stop();
    super.dispose();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    try {
      _speechEnabled = await _speechToText.initialize(
        onError: (obj) {
          debugPrint('WARN Khong the speech duoc $obj');
        },
        onStatus: (s) {
          debugPrint('FINE Speech status $s');
        },
        debugLogging: true,
      );
    } catch (e) {
      debugPrint('INFO Không khởi tạo được speech2text', e);
    }
    setState(() {});
    if (kDebugMode) {
      final locales = await _speechToText.locales();
      debugPrint('Supported locales: [${locales.map((e) => '{id: ${e.localeId}, name: ${e.name}}').join(', ')}]');
    }
    debugPrint('SpeechToText enabled: $_speechEnabled');
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(localeId: 'en-US', onResult: _onSpeechResult);
    setState(() {
      _isListening = true;
    });
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {
      _isListening = false;
    });
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    if (widget.onWordDetected != null) {
      widget.onWordDetected!(result.recognizedWords);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !_speechEnabled ? null : (_speechToText.isNotListening ? _startListening : _stopListening),
      child: Icon(
          _isListening ? Icons.mic : Icons.mic_off,
          color: _speechEnabled ? null : Colors.red,
        ),
    );
  }
}
