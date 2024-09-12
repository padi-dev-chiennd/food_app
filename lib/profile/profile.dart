import 'dart:ffi';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../widgets/appbar.dart';
import 'image_cubit.dart';

class ProFile extends StatefulWidget {
  const ProFile({super.key});

  @override
  State<ProFile> createState() => _ProFileState();
}

class _ProFileState extends State<ProFile> {
  final ImagePicker _picker = ImagePicker();
  @override
  void initState() {
    super.initState();
    context.read<ImageCubit>().loadImageFromDatabase();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarCusTome(),
        body: BlocProvider(
            create: (context) => ImageCubit(),
            child: BlocBuilder<ImageCubit, File?>(builder: (context, imageFile) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                        onTap: () => {_requestPermissionAndPickImage()},
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.deepOrange,
                            image: DecorationImage(image: imageFile != null
                                ? FileImage(imageFile)  as ImageProvider<Object>
                                : const AssetImage('images/default_image.jpg'))
                          ),
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Salvagebale",
                          style: TextStyle(color: Colors.black, fontSize: 18)),
                      IconButton(
                          onPressed: () => {},
                          icon: const Icon(CupertinoIcons.pen))
                    ],
                  ),
                  const Text(
                    "I Love to state food",
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              );
            })
        )
    );
  }
  Future<void> _requestPermissionAndPickImage() async {
    final plugin = DeviceInfoPlugin();
    final android = await plugin.androidInfo;

    PermissionStatus status;
    if (android.version.sdkInt >= 33) {
      // Request permission for photos
      status = await Permission.photos.status;
      if (status.isDenied) {
        status = await Permission.photos.request();
      }
    } else {
      // Request permission for storage
      status = await Permission.storage.status;
      if (status.isDenied) {
        status = await Permission.storage.request();
      }
    }

    if (status.isGranted) {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          final imageFile = File(image.path);
          context.read<ImageCubit>().updateImage(imageFile);
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permission denied. Cannot pick images.')),
      );
    }
  }
}
