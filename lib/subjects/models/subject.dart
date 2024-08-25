import 'package:campus_connect_frontend/utilities/utilities.dart';

class Subject extends Model {
  const Subject({required super.id});

  String get title => id;
  String get description => id;

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description
    };
  }
}
