import 'package:campus_connect_frontend/utilities/utilities.dart';

class Course extends Model {
  const Course({required super.id});

  String get title => id;


  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title
    };
  }

}