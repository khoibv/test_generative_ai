import 'package:envied/envied.dart';

part 'env.g.dart';

@envied
abstract class Env {
  @EnviedField(varName: 'GEMINI_KEY', obfuscate: true)
  static String geminiKey = _Env.geminiKey;

  @EnviedField(varName: 'GEMINI_MODEL')
  static const String geminiModel = _Env.geminiModel;

  @EnviedField(varName: 'CHAT_GPT_KEY', obfuscate: true)
  static String chatGptKey = _Env.chatGptKey;
}
