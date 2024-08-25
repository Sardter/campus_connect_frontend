

import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker_web/image_picker_web.dart';


class ImagePickerService extends FileService {

  Future<Uint8List?> _getImageWeb() async {
    return ImagePickerWeb.getImageAsBytes();
  }

  Future<List<Uint8List>?> _getImagesWeb() async {
    return ImagePickerWeb.getMultiImagesAsBytes();
  }

  Future<ImageMemoryData?> getImage(BuildContext context) async {
    final data = await _getImageWeb();
    return data == null ? null : MemoryMediaData.fromFile(data) as ImageMemoryData;
  }

  Future<List<MemoryMediaData>> pickMultipleMedia({bool imageOnly = false}) async {
    final data = await _getImagesWeb() ?? [];
    return data.map((e) => MemoryMediaData.fromFile(e) as ImageMemoryData).toList();
  }
  
  Future<VideoMemoryData?> getVideo() async {
    throw UnimplementedError();
  }
}
