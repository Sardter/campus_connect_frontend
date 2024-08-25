import 'package:campus_connect_frontend/items/items.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

class ItemTestService extends ModelService<Item> implements ItemService {
  @override
  Future<bool?> deleteItem({required ItemParameters itemParameters}) async {
    return true;
  }

  @override
  Future<Item?> getItem({required ItemParameters itemParameters}) async {
    return (await getList())?.first;
  }

  @override
  Future<List<Item>?> getList({QueryParameters<Model>? queryParameters}) async {
    return const [
      Item(id: "Item 1"),
      Item(id: "Item 2"),
      Item(id: "Item 3"),
      Item(id: "Item 4"),
      Item(id: "Item 5"),
      Item(id: "Item 6"),
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
  Future<Item?> postItem({required Item item}) async {
    return item;
  }

  @override
  Future<bool?> reportItem(
      {required ItemParameters itemParameters, required String reason}) async {
    return true;
  }

  @override
  Future<Item?> updateItem(
      {required Item updatedItem,
      required ItemParameters itemParameters}) async {
    return updatedItem;
  }
}
