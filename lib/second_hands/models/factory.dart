import 'package:campus_connect_frontend/courses/courses.dart';
import 'package:campus_connect_frontend/items/items.dart';
import 'package:campus_connect_frontend/second_hands/second_hands.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/foundation.dart';

import '../../users/models/user_factory.dart';

class SecondHandFactory extends ModelFactory<SecondHand> {
  @override
  SecondHand fromJson(Map<String, dynamic> json) {
    print("second hand json: ${json['num_likes']}");
    final media = json['media'] == null
            ? <NetworkImageData>[]
            : (json['media'] as List<dynamic>).map((e) => NetworkImageData(url: e)).toList();
    return SecondHand(
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
        item:
            json['item'] == null ? null : ItemFactory().fromJson(json),
        title: json['title'],
        media: media);
  }
}
