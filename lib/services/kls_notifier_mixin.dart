import 'package:flutter/cupertino.dart';

mixin KlsNotifierMixin<T extends Enum> on ChangeNotifier {
  T? _state;
  String? _errorMessage;
  String? _successMessage;

  // Getters for current state and messages
  T? get state => _state;
  set state(T? newState) => _state = newState;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;

  /// Update state of notifier and notify to listeners of the changes
  void updateState({
    required T newState,
    String errorMessage = '',
    String successMessage = '',
  }) {
    final changes = <String>[];
    if (_state != newState) {
      changes.add('state: $_state => $newState');
    }
    if (_successMessage != successMessage) {
      changes.add('success: $_successMessage => $successMessage');
    }
    if (_errorMessage != errorMessage) {
      changes.add('error: $_errorMessage => $errorMessage');
    }

    final icon = errorMessage.isNotEmpty ? '🚫' : '👉';
    debugPrint('$icon $T changed: {${changes.join(', ')}}');
    _state = newState;
    _errorMessage = errorMessage;
    _successMessage = successMessage;
    notifyListeners();
  }
}
