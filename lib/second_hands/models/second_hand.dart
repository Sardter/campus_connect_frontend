import 'package:campus_connect_frontend/courses/courses.dart';
import 'package:campus_connect_frontend/items/items.dart';
import 'package:campus_connect_frontend/posts/posts.dart';
import 'package:decimal/decimal.dart';

class SecondHand extends Post {
  final Decimal? price;
  final Course? course;
  final Item? item;

  const SecondHand(
      {required super.id,
      required super.allowedActions,
      required super.author,
      required super.description,
      required this.course,
      required this.price,
      required this.item,
      required super.title,
      required super.isFavorited,
      required super.favoriteCount,
      required super.media,
      super.type = PostType.shs});

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data.addAll({
      'content':{
      'price': price?.toString(),},
      'course': course?.toJson()['id'],
      'item': item?.toJson()['id']
    });
    return data;
  }
}
