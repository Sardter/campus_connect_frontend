import 'package:campus_connect_frontend/users/users.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

class Comment extends Model {
  final User author;
  final String content;
  final dynamic postId;
  final DateTime createdAt;
  final bool isFavorited;
  final int favoriteCount;
  final AllowedActions? allowedActions;

  const Comment(
      {required super.id,
      required this.author,
      required this.content,
      required this.postId,
      required this.allowedActions,
      this.isFavorited = false,
      this.favoriteCount = 0,
      required this.createdAt});

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'creator': author.toJson(),
      'content': content,
      'post_id': postId
    };
  }
}
