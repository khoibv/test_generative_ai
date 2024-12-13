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

  Future<void> startChat() async {
    chat = client.startChat();
  }

  Future<String?> sendChatMessage(String message) async {
    final content = Content.text(message);

    final response = await chat.sendMessage(content);
    return response.text;
  }

  Future<String?> createDocument(String topic) async {
    final prompt = 'Viết đoạn văn bản về chủ đề $topic.';
    final content = [Content.text(prompt)];
    final response = await _model.generateContent(
      content,
      generationConfig: GenerationConfig(
        maxOutputTokens: 2000,
      ),
    );

    print('response $response');

    return response.text;
  }
}
