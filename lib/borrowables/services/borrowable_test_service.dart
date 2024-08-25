import 'package:campus_connect_frontend/borrowables/borrowables.dart';
import 'package:campus_connect_frontend/courses/services/course_test_service.dart';
import 'package:campus_connect_frontend/items/models/item.dart';
import 'package:campus_connect_frontend/users/users.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:decimal/decimal.dart';

class BorrowableTestService extends ModelService<Borrowable>
    implements BorrowableService {
  @override
  Future<bool?> deleteItem({required ItemParameters itemParameters}) async {
    return true;
  }

  @override
  Future<bool?> favorite({required ItemParameters post}) async {
    return true;
  }

  @override
  Future<Borrowable?> getItem({required ItemParameters itemParameters}) async {
    return (await getList())?.first;
  }

  @override
  Future<List<Borrowable>?> getList(
      {QueryParameters<Model>? queryParameters}) async {
    return [
      Borrowable(
          id: 1,
          allowedActions: null,
          author: (await UserTestService()
              .getItem(itemParameters: const ItemParameters()))!,
          description: "Borrowable Description",
          course: (await CourseTestService()
              .getItem(itemParameters: const ItemParameters())),
          price: Decimal.fromInt(13),
          isFavorited: false,
          favoriteCount: 5,
          borrowStartTime: DateTime.now(),
          borrowEndTime: DateTime.now().add(const Duration(days: 5)),
          item: const Item(id: "basys"),
          title: "Borrowable Title 1",
          media: const []),
      Borrowable(
          id: 2,
          course: (await CourseTestService()
              .getItem(itemParameters: const ItemParameters())),
          allowedActions: null,
          author: (await UserTestService()
              .getItem(itemParameters: const ItemParameters()))!,
          description: "Borrowable Description",
          price: Decimal.fromInt(13),
          isFavorited: false,
          favoriteCount: 5,
          borrowStartTime: DateTime.now(),
          borrowEndTime: DateTime.now().add(const Duration(days: 5)),
          item: const Item(id: "basys"),
          title: "Borrowable Title 2",
          media: const []),
      Borrowable(
          id: 3,
          course: (await CourseTestService()
              .getItem(itemParameters: const ItemParameters())),
          allowedActions: null,
          author: (await UserTestService()
              .getItem(itemParameters: const ItemParameters()))!,
          description: "Borrowable Description",
          price: Decimal.fromInt(13),
          isFavorited: false,
          favoriteCount: 5,
          borrowStartTime: DateTime.now(),
          borrowEndTime: DateTime.now().add(const Duration(days: 5)),
          item: const Item(id: "basys"),
          title: "Borrowable Title 3",
          media: const []),
      Borrowable(
          id: 4,
          course: (await CourseTestService()
              .getItem(itemParameters: const ItemParameters())),
          allowedActions: null,
          author: (await UserTestService()
              .getItem(itemParameters: const ItemParameters()))!,
          description: "Borrowable Description",
          price: Decimal.fromInt(13),
          isFavorited: false,
          favoriteCount: 5,
          borrowStartTime: DateTime.now(),
          borrowEndTime: DateTime.now().add(const Duration(days: 5)),
          item: const Item(id: "basys"),
          title: "Borrowable Title 4",
          media: const []),
      Borrowable(
          id: 5,
          course: (await CourseTestService()
              .getItem(itemParameters: const ItemParameters())),
          allowedActions: null,
          author: (await UserTestService()
              .getItem(itemParameters: const ItemParameters()))!,
          description: "Borrowable Description",
          price: Decimal.fromInt(13),
          isFavorited: false,
          favoriteCount: 5,
          borrowStartTime: DateTime.now(),
          borrowEndTime: DateTime.now().add(const Duration(days: 5)),
          item: const Item(id: "basys"),
          title: "Borrowable Title 5",
          media: const []),
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
  Future<Borrowable?> postItem({required Borrowable item}) async {
    return item;
  }

  @override
  Future<bool?> reportItem(
      {required ItemParameters itemParameters, required String reason}) async {
    return true;
  }

  @override
  Future<Borrowable?> updateItem(
      {required Borrowable updatedItem,
      required ItemParameters itemParameters}) async {
    return updatedItem;
  }
}
