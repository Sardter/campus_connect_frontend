import 'package:campus_connect_frontend/items/models/item.dart';
import 'package:campus_connect_frontend/posts/posts.dart';
import 'package:campus_connect_frontend/posts/models/post.dart';


class LostAndFound extends Post {
  final String? location;
  final DateTime? date;
  final Item? item;

  const LostAndFound(
      {required super.id,
      required super.allowedActions,
      required super.author,
      required super.title,
      required this.item,
      required this.date,
      required this.location,
      required super.description,
      required super.isFavorited,
      required super.favoriteCount,
      required super.media,
      super.type = PostType.laf});

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data.addAll({
      'content': {'location': location,
      'date': date?.toString(),},
      'item': item?.toJson()['id']
    });
    return data;
  }
}
