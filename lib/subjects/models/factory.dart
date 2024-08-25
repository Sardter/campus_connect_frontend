import 'package:campus_connect_frontend/subjects/subjects.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

class SubjectFactory extends ModelFactory<Subject> {
  @override
  Subject fromJson(Map<String, dynamic> json) {
    return Subject(
        id: json['subject']);
  }
}
