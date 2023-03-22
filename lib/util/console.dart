import 'package:flutter/foundation.dart';

class AppConsole {
  static void log(dynamic str) {
    if (kDebugMode) {
      print("\n--------------------------------\n${str.toString()}\n---------------------------\n");
    }
  }
}
