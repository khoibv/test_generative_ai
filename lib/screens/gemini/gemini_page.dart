import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GeminiPage extends StatelessWidget {
  const GeminiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () => context.go('/gemini/chat'),
            child: const Text('Chat voi Gemini'),
          ),

          ElevatedButton(
            onPressed: () => context.go('/gemini/create-document'),
            child: const Text('Tạo văn bản'),
          ),
        ],
      ),
    );
  }
}
