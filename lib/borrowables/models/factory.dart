import 'package:campus_connect_frontend/borrowables/borrowables.dart';
import 'package:campus_connect_frontend/courses/courses.dart';
import 'package:campus_connect_frontend/items/models/models.dart';
import 'package:campus_connect_frontend/users/models/user_factory.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/widgets.dart';

class BorrowableFactory extends ModelFactory<Borrowable> {
  @override
  Borrowable fromJson(Map<String, dynamic> json) {
    print("well i want to watch smt");
    final media = json['media'] == null
            ? <NetworkImageData>[]
            : (json['media'] as List<dynamic>).map((e) => NetworkImageData(url: e)).toList();
    return Borrowable(
        id: json['id'],
        allowedActions: json['request_data']?['allowed_actions'] == null
            ? null
            : AllowedActions.fromJson(json['request_data']['allowed_actions']),
        author: UserFactory().fromJson(json['creator']),
        description: json['description'] ?? "",
        isFavorited: json['request_data']?['is_liked'] ?? false,
        favoriteCount: json['num_likes'] ?? 0,
        course: json['course'] == null
            ? null
            : CourseFactory().fromJson(json),
        price: Decimal.tryParse(json['content']?['price'] ?? ""),
        borrowStartTime: DateTime.tryParse(json['content']?['borrow_start_time'] ?? ""),
        borrowEndTime: DateTime.tryParse(json['content']?['borrow_end_time'] ?? ""),
        item:
            json['item'] == null ? null : ItemFactory().fromJson(json),
        title: json['title'],
        media: media);
  }
}
