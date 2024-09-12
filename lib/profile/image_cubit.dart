import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'dart:io';

import '../database/database_helper.dart';

class ImageCubit extends Cubit<File?> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  ImageCubit() : super(null);

  Future<void> updateImage(File? imageFile) async {
    emit(imageFile);
    if (imageFile != null) {
      await _databaseHelper.insertImage(imageFile.path);
    }
  }

  Future<void> loadImageFromDatabase() async {
    List<String> paths = await _databaseHelper.getImages();
    if (paths.isNotEmpty) {
      emit(File(paths.first)); // Emit the first image path for simplicity
    }
  }
}
