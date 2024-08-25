import 'package:campus_connect_frontend/users/users.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:meta/meta.dart';

enum PostType {shs, brw, dnt, laf}

abstract class Post extends ModelWithMedia {
  final AllowedActions? allowedActions;
  final int favoriteCount;
  final bool isFavorited;
  final User author;
  final String title;
  final String description;
  final PostType type;

  @override
  final List<ImageData> media;

  const Post({
    required super.id,
    required this.allowedActions,
    required this.author,
    required this.title,
    required this.isFavorited,
    required this.description,
    required this.media,
    required this.type,
    required this.favoriteCount,
  });
  
  @mustBeOverridden
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'creator': author.toJson(),
      'media': media.map((e) => e.toJson()).toList(),
      'title': title,
      'description': description,
      'type': type.toString().substring(9)
    };
  }
}

enum ItemCondition { notUsed, someWhatUsed, used }


String conditionToString(ItemCondition condition) {
  switch (condition) {
    case ItemCondition.notUsed:
      return "Not Used";
    case ItemCondition.someWhatUsed:
      return "Some What Used";
    case ItemCondition.used:
      return "Used";
  }
}