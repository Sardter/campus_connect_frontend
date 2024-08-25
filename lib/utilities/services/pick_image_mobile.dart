// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'dart:async';

class ImagePickerService extends FileService {
  final ImagePicker _picker = ImagePicker();
  File? _mediaFile;

  Future<List<MemoryMediaData>> pickMultipleMedia(
      {bool imageOnly = false}) async {
    return (imageOnly
            ? await _picker.pickMultiImage()
            : await _picker.pickMultipleMedia())
        .map((e) => MemoryMediaData.fromFile(File(e.path).readAsBytesSync()))
        .toList();
  }

  Future<void> _pickFromGallery(BuildContext context) async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    _mediaFile = picked == null ? null : File(picked.path);
    closePage(context);
  }

  Future<void> _pickVideo() async {
    final picked = await _picker.pickVideo(source: ImageSource.gallery);
    _mediaFile = picked == null ? null : File(picked.path);
  }

  Future<void> _pickFromCamera(BuildContext context) async {
    final picked = await _picker.pickImage(source: ImageSource.camera);
    _mediaFile = picked == null ? null : File(picked.path);
    closePage(context);
  }

  Future<ImageMemoryData?> getImage(BuildContext context) async {
    await _chooseImageDialog(context);
    final bytes = await _mediaFile!.readAsBytes();
    return _mediaFile == null
        ? null
        : ImageMemoryData(file: bytes, url: '', extention: getFileExtension(bytes) ?? ".png");
  }

  Future<VideoMemoryData?> getVideo() async {
    await _pickVideo();
    return _mediaFile == null
        ? null
        : VideoMemoryData(file: await _mediaFile!.readAsBytes(), url: '', extention: '.mp4');
  }

  Future<void> _chooseImageDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            GestureDetector(
              onTap: () async {
                await _pickFromGallery(context);
              },
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: 10),
                  Icon(LineIcons.photoVideo),
                  Text(
                    "Pick from gallery",
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () async {
                await _pickFromCamera(context);
              },
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: 10),
                  Icon(LineIcons.camera),
                  Text(
                    "Pick from camera",
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
