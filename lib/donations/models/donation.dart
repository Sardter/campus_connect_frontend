import 'package:campus_connect_frontend/subjects/models/subject.dart';
import 'package:campus_connect_frontend/posts/posts.dart';


class Donation extends Post {
  final double currentValue;
  final double targetValue;

  final Subject? subject;

  const Donation(
      {required super.id,
      required super.allowedActions,
      required this.currentValue,
      required this.targetValue,
      required this.subject,
      required super.author,
      required super.title,
      required super.isFavorited,
      required super.favoriteCount,
      required super.description,
      required super.media,
      super.type = PostType.dnt});

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data.addAll({
      'subject': subject?.toJson()['id'],
      'content':{
      'current_value': currentValue,
      'target_value': targetValue,}
    });
    return data;
  }
}
