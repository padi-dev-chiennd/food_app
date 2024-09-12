import 'package:flutter/services.dart';

class UCropper {
  static const MethodChannel _channel = MethodChannel('com.example.ucrop');

  // Hàm gọi UCrop trên Android
  static Future<String?> startUCrop(String imagePath) async {
    try {
      final String? result = await _channel.invokeMethod('startUCrop', {
        'imagePath': imagePath,
      });
      return result;
    } on PlatformException catch (e) {
      print("Failed to crop image: '${e.message}'.");
      return null;
    }
  }
}
