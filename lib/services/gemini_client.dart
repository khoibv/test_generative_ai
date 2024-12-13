import 'dart:io';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:test_ai/env.dart';

class GeminiClient {
  late GenerativeModel _model;

  GenerativeModel get client => _model;

  late ChatSession chat;

  GeminiClient() {
    _model = GenerativeModel(
      model: Env.geminiModel,
      apiKey: Env.geminiKey,
      // generationConfig: GenerationConfig(
      //   temperature: 1,
      //   topK: 40,
      //   topP: 0.95,
      //   maxOutputTokens: 8192,
      //   responseMimeType: 'text/plain',
      // ),
    );
  }

  Future<String?> prompt(
    String prompt, {
    List<String>? filePaths,
    int maxOutputTokens = 2000,
  }) async {
    final fileContents = filePaths == null ? [] : await Future.wait(filePaths.map((f) => File(f).readAsBytes()));

    final content = filePaths == null
        ? [Content.text(prompt)]
        : [
            Content.multi([
              TextPart(prompt),
              ...fileContents.map((image) => DataPart('image/jpeg', image)),
            ])
          ];

    final response = await _model.generateContent(
      content,
      generationConfig: GenerationConfig(
        maxOutputTokens: maxOutputTokens,
      ),
    );

    print('response $response');

    return response.text;
  }

  Future<void> startChat() async {
    chat = client.startChat();
  }

  Future<String?> sendChatMessage(String message) async {
    final content = Content.text(message);

    final response = await chat.sendMessage(content);
    return response.text;
  }

}
