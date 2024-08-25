import 'package:campus_connect_frontend/donations/donations.dart';
import 'package:campus_connect_frontend/subjects/subjects.dart';
import 'package:campus_connect_frontend/users/models/user_factory.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

class DonationFactory extends ModelFactory<Donation> {
  @override
  Donation fromJson(Map<String, dynamic> json) {
    final media = json['media'] == null
            ? <NetworkImageData>[]
            : (json['media'] as List<dynamic>).map((e) => NetworkImageData(url: e)).toList();
    return Donation(
        id: json['id'],
        allowedActions: json['request_data']?['allowed_actions'] == null
            ? null
            : AllowedActions.fromJson(json['request_data']['allowed_actions']),
        currentValue: json['content']?['current_value'].toDouble() ?? 0,
        targetValue: json['content']?['target_value'].toDouble() ?? 1,
        subject: json['subject'] == null
            ? null
            : SubjectFactory().fromJson(json),
        author: UserFactory().fromJson(json['creator']),
        title: json['title'],
        isFavorited: json['request_data']?['is_liked'] ?? false,
        favoriteCount: json['num_likes'] ?? 0,
        description: json['description'] ?? "",
        media: media);
  }
}
