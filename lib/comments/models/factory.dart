import 'package:campus_connect_frontend/comments/models/comment.dart';
import 'package:campus_connect_frontend/users/models/user_factory.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/foundation.dart';

class CommentFactory extends ModelFactory<Comment> {
  @override
  Comment fromJson(Map<String, dynamic> json) {
    print("comment json: ${json.toString()}");
    return Comment(
        id: json['id'],
        author: UserFactory().fromJson(json['creator']),
        content: json['content'],
        postId: json['post_id'],
        isFavorited: json['request_data']?['is_liked'] ?? false,
        favoriteCount: json['num_likes'] ?? 0,
        allowedActions: json['request_data']?['allowed_actions'] == null
            ? null
            : AllowedActions.fromJson(json['request_data']['allowed_actions']),
        createdAt:
            DateTime.tryParse(json['created_at'] ?? "") ?? DateTime.now());
  }
}
