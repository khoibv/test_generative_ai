import 'package:flutter/material.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:test_ai/env.dart';

class ChatGptPage extends StatelessWidget {
  const ChatGptPage({super.key});

  Future<void> callChatGpt() async {
    final openAI = OpenAI.instance.build(
      token: Env.chatGptKey,
      baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),
      enableLog: true,
    );

    final request = ChatCompleteText(messages: [
      Map.of({"role": "user", "content": 'Hello!'})
    ], maxToken: 200, model: Gpt4ChatModel());

    final response = await openAI.onChatCompletion(request: request);
    for (var element in response!.choices) {
      print("data -> ${element.message?.content}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: () async {
            await callChatGpt();
          },
          child: const Text('Chat')),
    );
  }
}
