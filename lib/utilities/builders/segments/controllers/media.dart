import 'package:campus_connect_frontend/utilities/utilities.dart';

class BuilderMediaController<T extends MediaData>
    extends BuilderSegmentController<List<MediaData>?> {
  BuilderMediaController({this.intialMedia});

  final List<T>? intialMedia;

  late List<T> selectedMedia =
      intialMedia?.cast<T>() ?? [];

  @override
  List<T>? get data => selectedMedia;

  @override
  List<String> get errorMesseges => [
    if (selectedMedia.length > 5) "5'ten fazla medya yüklenemez"
  ];
}
