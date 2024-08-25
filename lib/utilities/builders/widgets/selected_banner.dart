import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

class SelectedBanner extends StatefulWidget {
  const SelectedBanner(
      {super.key,
      required this.notifier,
      required this.child,
      this.height = 150,
      this.width = double.maxFinite});
  final ValueNotifier<ImageData?> notifier;
  final Widget child;
  final double height;
  final double width;

  @override
  State<SelectedBanner> createState() => _SelectedBannerState();
}

class _SelectedBannerState extends State<SelectedBanner> {
  final _service = ImagePickerService();

  ImageProvider? get _forgroundImage {
    if (widget.notifier.value == null) return null;
    if (widget.notifier.value is ImageFileData) {
      return FileImage((widget.notifier.value as ImageFileData).file);
    } else if (widget.notifier.value is ImageMemoryData) {
      return MemoryImage((widget.notifier.value as ImageMemoryData).file);
    }
    return CachedNetworkImageProvider(
        (widget.notifier.value as NetworkImageData).url);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final picked = await _service.getImage(context);
        if (picked == null) return;
        widget.notifier.value = picked;

        setState(() {});
      },
      child: ValueListenableBuilder(
          valueListenable: widget.notifier,
          builder: (context, value, child) {
            return Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: ThemeService.menuBackground,
                      image: widget.notifier.value == null
                          ? null
                          : DecorationImage(image: _forgroundImage!),
                      borderRadius: ThemeService.allAroundBorderRadius),
                  height: widget.height,
                  width: widget.width,
                  child: Container(
                    decoration: BoxDecoration(
                        color: ThemeService.menuBackground.withOpacity(0.4),
                        borderRadius: ThemeService.allAroundBorderRadius),
                    height: widget.height,
                    width: widget.width,
                    child: widget.child,
                  ),
                ),
                if (widget.notifier.value != null)
                  GestureDetector(
                    onTap: () {
                      widget.notifier.value = null;
                      setState(() {});
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                      padding: const EdgeInsets.all(5),
                      child: const Icon(Icons.close, size: 15),
                    ),
                  )
              ],
            );
          }),
    );
  }
}
