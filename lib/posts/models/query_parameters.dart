import 'package:campus_connect_frontend/posts/posts.dart';
import 'package:campus_connect_frontend/users/models/user.dart';
import 'package:campus_connect_frontend/utilities/filters/filters.dart';

class PostQueryParameters extends QueryParameters<Post> {
  final User? author;
  final String? course;
  final String? subject;
  final PostType postType;
  final String? order;

  const PostQueryParameters(
      {required super.searchQuery,
      this.author,
      this.course,
      required this.postType,
      this.order = "-created_at",
      super.sorted = true,
      this.subject});

  @override
  List<String?> get fieldsToStr => [
        fieldStringify<User>(author, (field) => 'creator=${field.id}'),
        fieldStringify<String>(course,
            (field) => 'course=$field'),
        fieldStringify(postType, (field) => 'type=${postType.toString().substring(9)}'),
        fieldStringify<String>(subject,
            (field) => 'subject=$field'),
        fieldStringify(order, (field) => "order_by=$field"),
      ];
}
