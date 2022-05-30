import 'package:flutter/services.dart';

class PushNotification {
  static const platform =
      MethodChannel('samples.flutter.dev/createNotification');

  static Future<void> createNotification() async {
    try {
      await platform.invokeMethod('create_alarm');
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print(e.message);
    }
  }
}
