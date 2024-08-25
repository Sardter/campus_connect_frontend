import 'package:campus_connect_frontend/items/models/item.dart';
import 'package:campus_connect_frontend/lost_and_founds/lost_and_founds.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

import '../../users/services/user_test_service.dart';

class LostAndFoundTestService extends ModelService<LostAndFound>
    implements LostAndFoundService {
  @override
  Future<bool?> deleteItem({required ItemParameters itemParameters}) async {
    return true;
  }

  @override
  Future<LostAndFound?> getItem(
      {required ItemParameters itemParameters}) async {
    return (await getList())?.first;
  }

  @override
  Future<List<LostAndFound>?> getList(
      {QueryParameters<Model>? queryParameters}) async {
    return [
      LostAndFound(
          id: 1,
          allowedActions: null,
          author: (await UserTestService()
              .getItem(itemParameters: const ItemParameters()))!,
          title: "Lost and Found Title 1",
          item: const Item(id: "basys"),
          date: DateTime.now(),
          isFavorited: false,
          favoriteCount: 5,
          location: "A binası",
          description: "Description",
          media: []),
      LostAndFound(
          id: 2,
          allowedActions: null,
          author: (await UserTestService()
              .getItem(itemParameters: const ItemParameters()))!,
          title: "Lost and Found Title 2",
          item: const Item(id: "basys"),
          date: DateTime.now(),
          isFavorited: false,
          favoriteCount: 5,
          location: "A binası",
          description: "Description",
          media: []),
      LostAndFound(
          id: 3,
          allowedActions: null,
          author: (await UserTestService()
              .getItem(itemParameters: const ItemParameters()))!,
          title: "Lost and Found Title 3",
          item: const Item(id: "basys"),
          date: DateTime.now(),
          isFavorited: false,
          favoriteCount: 5,
          location: "A binası",
          description: "Description",
          media: []),
      LostAndFound(
          id: 4,
          allowedActions: null,
          author: (await UserTestService()
              .getItem(itemParameters: const ItemParameters()))!,
          title: "Lost and Found Title 4",
          item: const Item(id: "basys"),
          date: DateTime.now(),
          isFavorited: false,
          favoriteCount: 5,
          location: "A binası",
          description: "Description",
          media: []),
      LostAndFound(
          id: 5,
          allowedActions: null,
          author: (await UserTestService()
              .getItem(itemParameters: const ItemParameters()))!,
          title: "Lost and Found Title 5",
          item: const Item(id: "basys"),
          date: DateTime.now(),
          isFavorited: false,
          favoriteCount: 5,
          location: "A binası",
          description: "Description",
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
  Future<LostAndFound?> postItem({required LostAndFound item}) async {
    return item;
  }

  @override
  Future<bool?> reportItem(
      {required ItemParameters itemParameters, required String reason}) async {
    return true;
  }

  @override
  Future<LostAndFound?> updateItem(
      {required LostAndFound updatedItem,
      required ItemParameters itemParameters}) async {
    return updatedItem;
  }

  @override
  Future<bool?> favorite({required ItemParameters post}) async {
    return true;
  }
}
