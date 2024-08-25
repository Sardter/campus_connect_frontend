import 'dart:io';
import 'dart:typed_data';

import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/material.dart';

abstract class MediaData {
  final String url;

  static const videoExtensions = ['.mp4', '.avi', '.mkv', '.flv', '.wmv'];
  static const imageExtensions = [
    '.jpg',
    '.jpeg',
    '.png',
    '.gif',
    '.bmp'
  ];

  const MediaData({required this.url});

  static bool isVideo(String filePath) {
    return filePath.isNotEmpty &&
        filePath.lastIndexOf('.') != -1 &&
        videoExtensions.contains(
            filePath.substring(filePath.lastIndexOf('.')).toLowerCase());
  }

  static bool isImage(String filePath) {
    return filePath.isNotEmpty &&
        filePath.lastIndexOf('.') != -1 &&
        imageExtensions.contains(
            filePath.substring(filePath.lastIndexOf('.')).toLowerCase());
  }

  Map<String, dynamic> toJson();
}

abstract class ImageData implements MediaData {}

abstract class VideoData implements MediaData {}

abstract class NetworkMediaData extends MediaData {
  factory NetworkMediaData.fromURL(String url) {
    String parsed = url.split('?').first;
    if (MediaData.isImage(parsed)) {
      return NetworkImageData(url: url);
    } else if (MediaData.isVideo(parsed)) {
      return NetworkVideoData(url: url);
    }
    return NetworkEmptyMediaData();
  }

  const NetworkMediaData({required super.url});

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': url.split('?').first.split('/').last,
      'empty': false,
      'file_type': null
    };
  }
}

class NetworkEmptyMediaData extends NetworkMediaData {
  NetworkEmptyMediaData({super.url = ""});

  @override
  Map<String, dynamic> toJson() {
    return {'name': null, 'empty': true, 'file_type': null};
  }
}

class UnUploadedMediaData extends MediaData {
  final Map<String, dynamic> fields;
  const UnUploadedMediaData({required super.url, required this.fields});

  factory UnUploadedMediaData.fromJson(Map<String, dynamic> json) {
    return UnUploadedMediaData(url: json['url'], fields: json['fields']);
  }

  @override
  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }
}

class NetworkImageData extends NetworkMediaData implements ImageData {
  const NetworkImageData({required super.url});
}

class NetworkVideoData extends NetworkMediaData implements VideoData {
  const NetworkVideoData({required super.url});
}

abstract class FileMediaData extends MediaData {
  final File file;

  const FileMediaData({required this.file, required super.url});

  factory FileMediaData.fromFile(File file) {
    print(file.path);

    if (MediaData.isImage(file.path)) {
      return ImageFileData(file: file, url: file.path);
    } else if (MediaData.isVideo(file.path)) {
      return VideoFileData(file: file, url: file.path);
    }
    throw UnimplementedError(file.path);
  }

  String get extention => file.path.split('.').last;

  String get type;

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': null,
      'file_type': extention,
      'empty': false
    };
  }
}

class ImageFileData extends FileMediaData implements ImageData {
  const ImageFileData({required super.file, required super.url});

  @override
  String get type => "image";
}

class VideoFileData extends FileMediaData implements VideoData {
  const VideoFileData({required super.file, required super.url});

  @override
  String get type => "video";
}

abstract class MemoryMediaData extends MediaData {
  final Uint8List file;
  final String extention;

  MemoryMediaData({required this.file, required super.url, required this.extention});

  factory MemoryMediaData.fromFile(Uint8List file) {
    final extention = getFileExtension(file);

    if (extention != null) {
      if (MediaData.isImage(extention)) {
        return ImageMemoryData(file: file, url: "", extention: extention);
      } else if (MediaData.isVideo(extention)) {
        return VideoMemoryData(file: file, url: "", extention: extention);
      }
    }

    throw UnimplementedError(extention);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'name': null, 'file_type': getFileExtension(file), 'empty': false};
  }
}

class ImageMemoryData extends MemoryMediaData implements ImageData {
   ImageMemoryData(
      {required super.file, required super.url, required super.extention});
}

class VideoMemoryData extends MemoryMediaData implements VideoData {
   VideoMemoryData(
      {required super.file, required super.url, required super.extention});
}

abstract class ModelWithMedia extends Model {
  const ModelWithMedia({required super.id});

  List<MediaData?> get media;
}
