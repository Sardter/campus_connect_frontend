import 'package:campus_connect_frontend/posts/posts.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

abstract class PostService<T extends Post> extends ModelService<T> {
  Future<bool?> favorite({required ItemParameters post});
}