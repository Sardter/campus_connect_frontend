import 'package:campus_connect_frontend/courses/courses.dart';
import 'package:campus_connect_frontend/items/items.dart';
import 'package:campus_connect_frontend/second_hands/second_hands.dart';
import 'package:campus_connect_frontend/users/users.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:decimal/decimal.dart';

class SecondHandTestService extends ModelService<SecondHand>
    implements SecondHandService {
  @override
  Future<bool?> deleteItem({required ItemParameters itemParameters}) async {
    return true;
  }

  @override
  Future<bool?> favorite({required ItemParameters post}) async {
    return true;
  }

  @override
  Future<SecondHand?> getItem({required ItemParameters itemParameters}) async {
    return (await getList())?.first;
  }

  @override
  Future<List<SecondHand>?> getList(
      {QueryParameters<Model>? queryParameters}) async {
    return [
      SecondHand(
          id: 1,
          allowedActions: const AllowedActions(
              canUpdate: true, canDelete: true, canHide: true, canReport: true),
          author: (await UserTestService()
              .getItem(itemParameters: const ItemParameters()))!,
          description: "Second Hand Description",
          isFavorited: false,
          favoriteCount: 5,
          price: Decimal.fromInt(13),
          course: (await CourseTestService()
              .getItem(itemParameters: const ItemParameters())),
          item: (await ItemTestService()
              .getItem(itemParameters: const ItemParameters()))!,
          title: "Second Hand Item 1",
          media: const [
            NetworkImageData(
                url:
                    "https://m.media-amazon.com/images/I/61aLQVV6KhL._AC_UF1000,1000_QL80_.jpg"),
            NetworkImageData(
                url:
                    "https://m.media-amazon.com/images/I/61aLQVV6KhL._AC_UF1000,1000_QL80_.jpg"),
            NetworkImageData(
                url:
                    "https://m.media-amazon.com/images/I/61aLQVV6KhL._AC_UF1000,1000_QL80_.jpg"),
            NetworkImageData(
                url:
                    "https://m.media-amazon.com/images/I/61aLQVV6KhL._AC_UF1000,1000_QL80_.jpg"),
            NetworkImageData(
                url:
                    "https://m.media-amazon.com/images/I/61aLQVV6KhL._AC_UF1000,1000_QL80_.jpg"),
          ]),
      SecondHand(
          id: 1,
          allowedActions: null,
          author: (await UserTestService()
              .getItem(itemParameters: const ItemParameters()))!,
          description: "Second Hand Description",
          course: (await CourseTestService()
              .getItem(itemParameters: const ItemParameters())),
          price: Decimal.fromInt(13),
          isFavorited: false,
          favoriteCount: 5,
          item: (await ItemTestService()
              .getItem(itemParameters: const ItemParameters()))!,
          title: "Second Hand Item 1",
          media: []),
      SecondHand(
          id: 1,
          allowedActions: null,
          author: (await UserTestService()
              .getItem(itemParameters: const ItemParameters()))!,
          description: "Second Hand Description",
          course: (await CourseTestService()
              .getItem(itemParameters: const ItemParameters())),
          price: Decimal.fromInt(13),
          isFavorited: false,
          favoriteCount: 5,
          item: (await ItemTestService()
              .getItem(itemParameters: const ItemParameters()))!,
          title: "Second Hand Item 1",
          media: []),
      SecondHand(
          id: 1,
          allowedActions: null,
          author: (await UserTestService()
              .getItem(itemParameters: const ItemParameters()))!,
          description: "Second Hand Description",
          course: (await CourseTestService()
              .getItem(itemParameters: const ItemParameters())),
          price: Decimal.fromInt(13),
          isFavorited: false,
          favoriteCount: 5,
          item: (await ItemTestService()
              .getItem(itemParameters: const ItemParameters()))!,
          title: "Second Hand Item 1",
          media: []),
      SecondHand(
          id: 1,
          allowedActions: null,
          author: (await UserTestService()
              .getItem(itemParameters: const ItemParameters()))!,
          description: "Second Hand Description",
          course: (await CourseTestService()
              .getItem(itemParameters: const ItemParameters())),
          price: Decimal.fromInt(13),
          isFavorited: false,
          favoriteCount: 5,
          item: (await ItemTestService()
              .getItem(itemParameters: const ItemParameters()))!,
          title: "Second Hand Item 1",
          media: []),
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
  Future<SecondHand?> postItem({required SecondHand item}) async {
    return item;
  }


  @override
  Future<bool?> reportItem(
      {required ItemParameters itemParameters, required String reason}) async {
    return true;
  }

  @override
  Future<SecondHand?> updateItem(
      {required SecondHand updatedItem,
      required ItemParameters itemParameters}) async {
    return updatedItem;
  }
}
