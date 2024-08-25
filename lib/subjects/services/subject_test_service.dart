import 'package:campus_connect_frontend/subjects/subjects.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

class SubjectTestService extends ModelService<Subject>
    implements SubjectService {
  @override
  Future<bool?> deleteItem({required ItemParameters itemParameters}) async {
    return true;
  }

  @override
  Future<Subject?> getItem({required ItemParameters itemParameters}) async {
    return (await getList())?.first;
  }

  @override
  Future<List<Subject>?> getList({QueryParameters<Model>? queryParameters}) async {
    return const [
      Subject(id: "Subject 1"),
      Subject(id:"Subject 2"),
      Subject(id:"Subject 3"),
      Subject(id: "Subject 4"),
      Subject(id: "Subject 5"),
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
  Future<Subject?> postItem({required Subject item}) async {
    return item;
  }

  @override
  Future<bool?> reportItem(
      {required ItemParameters itemParameters, required String reason}) async {
    return true;
  }

  @override
  Future<Subject?> updateItem(
      {required Subject updatedItem, required ItemParameters itemParameters}) async {
    return updatedItem;
  }
}
