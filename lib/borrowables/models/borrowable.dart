import 'package:campus_connect_frontend/courses/courses.dart';
import 'package:campus_connect_frontend/items/items.dart';
import 'package:campus_connect_frontend/posts/posts.dart';
import 'package:decimal/decimal.dart';

class Borrowable extends Post {
  final Decimal? price;
  final Item? item;
  final Course? course;
  final DateTime? borrowStartTime;
  final DateTime? borrowEndTime;

  Duration? get duration => borrowEndTime == null || borrowStartTime == null
      ? null
      : borrowEndTime!.difference(borrowStartTime!);

  const Borrowable(
      {required super.id,
      required super.allowedActions,
      required super.author,
      required super.description,
      required this.course,
      required super.isFavorited,
      required super.favoriteCount,
      required this.price,
      required this.borrowStartTime,
      required this.borrowEndTime,
      required this.item,
      required super.title,
      required super.media,
      super.type = PostType.brw});

  @override
  Map<String, dynamic> toJson() {
    final post = super.toJson();
    post.addAll({
      'item': item?.toJson()['id'],
      'course': course?.toJson()['id'],
      'content':{
      'borrow_start_time': borrowStartTime.toString(),
      'borrow_end_time': borrowEndTime.toString(),
      'price': price.toString(),}
    });
    return post;
  }
}
