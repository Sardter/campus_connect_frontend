import 'package:campus_connect_frontend/courses/courses.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

class CourseFactory extends ModelFactory<Course> {
  @override
  Course fromJson(Map<String, dynamic> json) {
    return Course(id: json['course']);
  }
}
