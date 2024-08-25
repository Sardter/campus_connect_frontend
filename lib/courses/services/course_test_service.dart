import 'package:campus_connect_frontend/courses/courses.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

class CourseTestService extends ModelService<Course> implements CourseService {
  @override
  Future<bool?> deleteItem({required ItemParameters itemParameters}) async {
    return true;
  }

  @override
  Future<Course?> getItem({required ItemParameters itemParameters}) async {
    return (await getList())?.first;
  }

  @override
  Future<List<Course>?> getList(
      {QueryParameters<Model>? queryParameters}) async {
    return const [
      Course(id: "CS 223"),
      Course(id: "CS 223"),
      Course(id: "CS 223"),
      Course(id: "CS 223"),
      Course(id: "CS 223"),
      Course(id: "CS 223"),
    ];
  }

  @override
  Future<int?> getListCount({QueryParameters<Model>? queryParameters}) async {
    return (await getList())?.length;
  }

  @override
  Future<bool?> hideItem({required ItemParameters itemParameters}) async {
    return true;
  }

  @override
  Future<Course?> postItem({required Course item}) async {
    return item;
  }

  @override
  Future<bool?> reportItem(
      {required ItemParameters itemParameters, required String reason}) async {
    return true;
  }

  @override
  Future<Course?> updateItem(
      {required Course updatedItem,
      required ItemParameters itemParameters}) async {
    return updatedItem;
  }
}
