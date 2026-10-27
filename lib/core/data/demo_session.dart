import 'package:flutter/foundation.dart';

/// Profile edits affect only the current UI demonstration.
class DemoSession extends ChangeNotifier {
  String name = 'Максим';
  String email = 'max@example.com';

  void updateProfile(String newName, String newEmail) {
    name = newName;
    email = newEmail;
    notifyListeners();
  }
}
