import 'package:campus_connect_frontend/comments/comments.dart';
import 'package:campus_connect_frontend/users/users.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

class CommentTestService extends ModelService<Comment>
    implements CommentService {
  @override
  Future<bool?> deleteItem({required ItemParameters itemParameters}) async {
    return true;
  }

  @override
  Future<Comment?> getItem({required ItemParameters itemParameters}) async {
    return (await getList())?.first;
  }

  @override
  Future<List<Comment>?> getList(
      {QueryParameters<Model>? queryParameters}) async {
    return [
      Comment(
          id: 1,
          author: (await UserTestService()
              .getItem(itemParameters: const ItemParameters()))!,
          content: "Comment 1",
          createdAt: DateTime.now(),
          postId: 1,
          allowedActions: const AllowedActions(
              canUpdate: true,
              canDelete: true,
              canHide: true,
              canReport: true)),
      Comment(
          id: 2,
          author: (await UserTestService()
              .getItem(itemParameters: const ItemParameters()))!,
          postId: 1,
          content: "Comment 2",
          createdAt: DateTime.now(),
          allowedActions: null),
      Comment(
          id: 3,
          author: (await UserTestService()
              .getItem(itemParameters: const ItemParameters()))!,
          postId: 1,
          content: "Comment 3",
          createdAt: DateTime.now(),
          allowedActions: null),
      Comment(
          id: 4,
          author: (await UserTestService()
              .getItem(itemParameters: const ItemParameters()))!,
          postId: 1,
          content: "Comment 4",
          createdAt: DateTime.now(),
          allowedActions: null),
      Comment(
          id: 5,
          author: (await UserTestService()
              .getItem(itemParameters: const ItemParameters()))!,
          postId: 1,
          content: "Comment 5",
          createdAt: DateTime.now(),
          allowedActions: null),
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
  Future<Comment?> postItem({required Comment item}) async {
    return item;
  }

  @override
  Future<bool?> reportItem(
      {required ItemParameters itemParameters, required String reason}) async {
    return true;
  }

  @override
  Future<Comment?> updateItem(
      {required Comment updatedItem,
      required ItemParameters itemParameters}) async {
    return updatedItem;
  }

  @override
  Future<bool?> favorite({required ItemParameters itemParameters}) async {
    return true;
  }
}
