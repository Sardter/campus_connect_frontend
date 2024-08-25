import 'package:campus_connect_frontend/utilities/utilities.dart';

class Item extends Model {
  const Item({required super.id});

  String get title => id;

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
    };
  }
}
