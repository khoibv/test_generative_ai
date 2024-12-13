import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_ai/screens/gemini/chat.dart';
import 'package:test_ai/screens/gemini/create_document.dart';
import 'package:test_ai/services/ai_service.dart';

import 'screens/index.dart';

final aiService = AiService();

/// The route configuration.
final GoRouter appRoutes = GoRouter(
  observers: <NavigatorObserver>[MyNavObserver(debugLogDiagnostics: false)],
  debugLogDiagnostics: true,
  initialLocation: '/gemini',
  routes: [
    ShellRoute(
      navigatorKey: GlobalKey<NavigatorState>(),
      builder: (context, state, child) {
        return MainPage(child: child);
      },
      routes: [
        GoRoute(
          path: '/gemini',
          pageBuilder: (context, state) => const MaterialPage(child: GeminiPage()),
          routes: [
            GoRoute(
              path: 'chat',
              builder: (context, state) => GeminiChatPage(
                aiService: aiService,
              ),
            ),

            GoRoute(
              path: 'create-document',
              builder: (context, state) => GeminiCreateDocumentPage(
                aiService: aiService,
              ),
            ),
          ],
        ),
        GoRoute(
          path: '/chatgpt',
          pageBuilder: (context, state) => const MaterialPage(child: ChatGptPage()),
          // routes: [
          //   GoRoute(
          //     path: 'chat',
          //     builder: (context, state) => const ChatGptChatPage(),
          //   ),
          // ],
        ),
        GoRoute(
          path: '/search',
          pageBuilder: (context, state) => const MaterialPage(child: SearchPage()),
          // routes: [
          //   GoRoute(
          //     path: 'chat',
          //     builder: (context, state) => const ChatGptChatPage(),
          //   ),
          // ],
        ),
      ],
    ),
  ],
);

/// The Navigator observer.
/// reference: https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/others/nav_observer.dart
class MyNavObserver extends NavigatorObserver {
  final bool debugLogDiagnostics;
  late ValueChanged<String> _logger;

  /// Creates a [MyNavObserver].
  MyNavObserver({this.debugLogDiagnostics = false}) {
    if (debugLogDiagnostics) {
      _logger = log;
    } else {
      _logger = logMute;
    }
  }

  void log(String message) {
    debugPrint(message);
  }

  void logMute(String message) {
    // do nothing
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _logger('didPush: ${route.str}, previousRoute= ${previousRoute?.str}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _logger('didPop: ${route.str}, previousRoute= ${previousRoute?.str}');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _logger('didRemove: ${route.str}, previousRoute= ${previousRoute?.str}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _logger('didReplace: new= ${newRoute?.str}, old= ${oldRoute?.str}');
  }

// @override
// void didStartUserGesture(
//   Route<dynamic> route,
//   Route<dynamic>? previousRoute,
// ) =>
//     log.fine('didStartUserGesture: ${route.str}, '
//         'previousRoute= ${previousRoute?.str}');
//
// @override
// void didStopUserGesture() => log.fine('didStopUserGesture');
}

extension on Route<dynamic> {
  String get str => 'route(${settings.name}: ${settings.arguments})';
}
