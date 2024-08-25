import 'package:campus_connect_frontend/borrowables/borrowables.dart';
import 'package:campus_connect_frontend/posts/posts.dart';

abstract class BorrowableService<T extends Borrowable> extends PostService<T> {

}