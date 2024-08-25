import 'package:campus_connect_frontend/comments/comments.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

abstract class CommentService<T extends Comment> extends ModelService<T> {
  Future<bool?> favorite({required ItemParameters itemParameters});
}
