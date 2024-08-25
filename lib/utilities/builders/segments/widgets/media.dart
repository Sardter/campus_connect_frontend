import 'package:flutter/material.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

class BuilderMediaSegment<T extends MediaData> extends StatefulWidget
    implements CreatePageSegment {
  const BuilderMediaSegment({super.key, required this.mediaController});
  final BuilderMediaController<T> mediaController;

  @override
  State<BuilderMediaSegment<T>> createState() => _BuilderMediaSegmentState<T>();

  @override
  IconData get icon => Icons.photo_camera;

  @override
  String get label => "Medya";
}

class _BuilderMediaSegmentState<T extends MediaData>
    extends State<BuilderMediaSegment<T>> {
  final _picker = ImagePickerService();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * 0.81,
      child: ReorderableGridView.count(
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 3,
        dragWidgetBuilder: (index, child) {
          return SocialUtilCard(
            width: MediaQuery.of(context).size.width * 0.35,
            height: MediaQuery.of(context).size.width * 0.35,
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            child: child,
          );
        },
        onReorder: (oldIndex, newIndex) {
          setState(() {
            final element =
                widget.mediaController.selectedMedia.removeAt(oldIndex);
            widget.mediaController.selectedMedia.insert(newIndex, element);
          });
        },
        footer: [
          GestureDetector(
            onTap: () async {
              widget.mediaController.selectedMedia +=
                  (await _picker.pickMultipleMedia(imageOnly: T is ImageData))
                      .cast<T>()
                      .toList();

              setState(() {});
            },
            child: SocialUtilCard(
              width: MediaQuery.of(context).size.width * 0.35,
              height: MediaQuery.of(context).size.width * 0.35,
              padding: EdgeInsets.zero,
              child: const Icon(Icons.add_a_photo),
            ),
          ),
        ],
        children: List.generate(
          widget.mediaController.selectedMedia.length,
          (index) {
            final media = widget.mediaController.selectedMedia[index];
            return Stack(
              alignment: Alignment.topRight,
              key: UniqueKey(),
              children: [
                SocialUtilCard(
                  width: MediaQuery.of(context).size.width * 0.35,
                  height: MediaQuery.of(context).size.width * 0.35,
                  padding: EdgeInsets.zero,
                  child: ClipRRect(
                    borderRadius: ThemeService.allAroundBorderRadius,
                    child: media is VideoData
                        ? SocialUtilVideoThumbnail(url: media.url)
                        : SocialUtilImage(
                            image: media as ImageData,
                            useDefault: false,
                            defaultImage: null),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.mediaController.selectedMedia.removeAt(index);
                    });
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.red, shape: BoxShape.circle),
                    padding: const EdgeInsets.all(2),
                    child: const Icon(
                      Icons.close,
                      size: 15,
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
