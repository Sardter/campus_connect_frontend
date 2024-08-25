import 'package:campus_connect_frontend/utilities/utilities.dart';

class NotificationModel extends Model {
  final String title;
  final String? description;
  final ImageData? image;

  const NotificationModel({
    required super.id,
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image?.toJson()
    };
  }
}
