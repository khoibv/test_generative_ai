import 'package:flutter/material.dart';
import 'package:test_ai/services/gemini_client.dart';
import 'package:test_ai/services/kls_notifier_mixin.dart';

enum AiState {
  loading,
  success,
  error,
}

enum AiType {
  gemini,
  chatgpt,
}

class AiService extends ChangeNotifier with KlsNotifierMixin<AiState> {
  final GeminiClient _geminiClient;
  final type = AiType.gemini;

  AiService() : _geminiClient = GeminiClient();

  Future<void> startChat() async {
    switch (type) {
      case AiType.gemini:
        await _geminiClient.startChat();
        break;

      default:
        throw UnsupportedError('This type ($type) is not supported.');
    }
  }

  Future<String?> sendChatMessage(String message) async {
    switch (type) {
      case AiType.gemini:
        return await _geminiClient.sendChatMessage(message);

      default:
        throw UnsupportedError('This type ($type) is not supported.');
    }
  }

  /// tạo văn bản theo chủ đề chỉ định
  Future<String?> createDocument(String topic) async {
    // updateState(newState: AiState.loading);

    switch (type) {
      case AiType.gemini:
        return await _geminiClient.createDocument(topic);
      default:
        throw UnsupportedError('This type ($type) is not supported.');
    }
  }
}
