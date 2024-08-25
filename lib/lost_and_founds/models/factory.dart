import 'package:campus_connect_frontend/items/models/factory.dart';
import 'package:campus_connect_frontend/lost_and_founds/models/models.dart';
import 'package:campus_connect_frontend/users/models/user_factory.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/foundation.dart';

class LoastAndFoundFactory extends ModelFactory<LostAndFound> {
  @override
  LostAndFound fromJson(Map<String, dynamic> json) {
    print('from json: $json');
    final media = json['media'] == null
            ? <NetworkImageData>[]
            : (json['media'] as List<dynamic>).map((e) => NetworkImageData(url: e)).toList();
    return LostAndFound(
        id: json['id'],
        allowedActions: json['request_data']?['allowed_actions'] == null
            ? null
            : AllowedActions.fromJson(json['request_data']['allowed_actions']),
        author: UserFactory().fromJson(json['creator']),
        title: json['title'],
        item: json['item'] == null ? null : ItemFactory().fromJson(json),
        isFavorited: json['request_data']?['is_liked'] ?? false,
        favoriteCount: json['num_likes'] ?? 0,
        date: DateTime.tryParse(json['content']?['date'] ?? ""),
        location: json['content']?['location'],
        description: json['description'],
        media: media);
  }
}
