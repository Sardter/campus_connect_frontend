import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class SocialUtilImage extends StatelessWidget {
  final ImageData? image;
  final bool useDefault;
  final double? width;
  final double? height;
  final String? defaultImage;
  final BoxFit boxFit = BoxFit.cover;
  final String assetImage = "assets/images/defaultB.jpg";

  const SocialUtilImage(
      {Key? key,
      required this.image,
      required this.useDefault,
      required this.defaultImage,
      this.width,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (image == null && defaultImage == null) {
      return Image.asset(
        assetImage,
        fit: boxFit,
        height: height,
        width: width,
      );
    }
    if (image != null) {
      if (image is ImageFileData) {
        return Image.file(
          (image as ImageFileData).file,
          fit: BoxFit.cover,
          height: height,
          width: width,
        );
      } else if (image is ImageMemoryData) {
        return Image.memory(
          (image as ImageMemoryData).file,
          fit: BoxFit.cover,
          height: height,
          width: width,
        );
      }
    }
    print("image url: ${(image as NetworkImageData?)?.url}");
    return Image.network(
      (image as NetworkImageData?)?.url ?? defaultImage!,
      fit: BoxFit.cover,
      height: height,
      width: width,
      /* loadingBuilder: (context, url, _) => useDefault
          ? Image.asset(
              assetImage,
              fit: BoxFit.cover,
              height: height,
              width: width,
            )
          : const Icon(Icons.image), */
      errorBuilder: (context, url, error) {
        print(error.toString());
        return SizedBox(
          height: height,
          width: width,
          child: const Icon(Icons.image),
        );
      },
    );
  }
}

class SocialUtilImageProvider extends StatelessWidget {
  final ImageData? image;
  final String? defaultImage;
  final double? radius;

  const SocialUtilImageProvider(
      {Key? key, required this.image, this.radius, required this.defaultImage})
      : super(key: key);

  ImageProvider? get _forgroundImage {
    if (image == null && defaultImage == null) return null;
    if (image is ImageFileData) {
      return FileImage((image as ImageFileData).file);
    } else if (image is ImageMemoryData) {
      return MemoryImage((image as ImageMemoryData).file);
    }
    return NetworkImage(
        (image as NetworkImageData?)?.url ?? defaultImage!,);
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      foregroundImage: _forgroundImage,
      // backgroundImage: AssetImage("assets/images/defaultP.png"),
      backgroundColor: Colors.black12,
      radius: radius,
    );
  }
}

class SocialUtilVideoThumbnail extends StatefulWidget {
  const SocialUtilVideoThumbnail(
      {super.key, required this.url, this.height, this.width, this.quality});
  final String url;
  final int? height;
  final int? width;
  final int? quality;

  @override
  State<SocialUtilVideoThumbnail> createState() =>
      _SocialUtilVideoThumbnailState();
}

class _SocialUtilVideoThumbnailState extends State<SocialUtilVideoThumbnail> {
  Future<Uint8List?> _getThumbnail() async {
    return await VideoThumbnail.thumbnailData(
        video: widget.url,
        maxHeight: widget.height ?? 0,
        maxWidth: widget.width ?? 0,
        quality: widget.quality ?? 10);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: _getThumbnail(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SizedBox(
              width: widget.width?.toDouble(),
              height: widget.height?.toDouble());
        }
        return Image.memory(
          snapshot.data!,
          fit: BoxFit.cover,
          height: widget.height?.toDouble(),
          width: widget.width?.toDouble(),
        );
      },
    );
  }
}
