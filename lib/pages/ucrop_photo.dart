import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/widgets/appbar.dart';

class UcropPhoto extends StatefulWidget {
  const UcropPhoto({super.key});

  @override
  State<UcropPhoto> createState() => _UcropPhotoState();
}

class _UcropPhotoState extends State<UcropPhoto> {
  String defaultAsset = 'images/default_image.jpg';
  static const MethodChannel _channel = MethodChannel('com.example.food_app/ucrop');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCusTome(),
       body: InkWell(
         onTap: () => {
           _sendImagePathToNative(defaultAsset)
         },
         child:Image.asset(defaultAsset) ,
       )

    );
  }
  Future<void> _sendImagePathToNative(String imagePath) async {
    try {
      final result = await _channel.invokeMethod('processImage', {'imagePath': imagePath});
      print('Native result: $result');
    } on PlatformException catch (e) {
      print("Failed to send image path: '${e.message}'.");
    }
  }
}
