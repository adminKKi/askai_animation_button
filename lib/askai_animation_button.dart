
import 'dart:async';

import 'package:flutter/services.dart';
export 'animationButton.dart';

class AskaiAnimationButton {
  static const MethodChannel _channel =
      const MethodChannel('askai_animation_button');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
