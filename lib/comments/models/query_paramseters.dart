import 'package:campus_connect_frontend/comments/models/comment.dart';
import 'package:campus_connect_frontend/posts/posts.dart';
import 'package:campus_connect_frontend/utilities/filters/filters.dart';

class CommentQueryParameters extends QueryParameters<Comment> {
  final Post? post;
  final String? order;
  const CommentQueryParameters({super.searchQuery, this.post,
      this.order = "-created_at",
      super.sorted = true,});
  
  @override
  List<String?> get fieldsToStr => [
    fieldStringify<Post>(post, (field) => "post=${field.id}"),
    fieldStringify(order, (field) => "order_by=$field"),
  ];
}