import 'package:flutter/material.dart';
import 'package:campus_connect_frontend/utilities/models/media.dart';
import 'package:campus_connect_frontend/utilities/widgets/image_widgets.dart';

class MediaImage extends StatelessWidget {
  const MediaImage({super.key, required this.imageData});
  final ImageData imageData;

  @override
  Widget build(BuildContext context) {
    return SocialUtilImage(
      image: imageData,
      defaultImage: null,
      useDefault: false,
    );
  }
}
