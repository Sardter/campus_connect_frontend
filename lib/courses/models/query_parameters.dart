import 'package:campus_connect_frontend/courses/courses.dart';
import 'package:campus_connect_frontend/users/models/user.dart';
import 'package:campus_connect_frontend/utilities/filters/filters.dart';

class CourseQueryParameters extends QueryParameters<Course> {
  final User? user;

  const CourseQueryParameters({required super.searchQuery, this.user});
  
  @override
  List<String?> get fieldsToStr => [
    fieldStringify<User>(user, (field) => "user=${field.id}")
  ];
}