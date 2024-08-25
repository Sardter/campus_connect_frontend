import 'dart:convert';

import 'package:campus_connect_frontend/messaging/messaging.dart';
import 'package:campus_connect_frontend/users/users.dart';
import 'package:campus_connect_frontend/utilities/filters/item_paremeters.dart';
import 'package:campus_connect_frontend/utilities/filters/query_parameters.dart';
import 'package:campus_connect_frontend/utilities/models/model.dart';

class MessageTestService extends MessageService {
  @override
  Future<bool?> deleteItem({required ItemParameters itemParameters}) async {
    return true;
  }

  @override
  Future<MessageModel?> getItem(
      {required ItemParameters itemParameters}) async {
    return (await getList())?.first;
  }

  @override
  Future<List<MessageModel>?> getList(
      {QueryParameters<Model>? queryParameters}) async {
    return [
      MessageModel(
          id: 1,
          content: "wow mesaj",
          room: 1,
          author: (await UserTestService()
              .getItem(itemParameters: const ItemParameters()))!,
          read: false,
          dateTime: DateTime.now()),
      MessageModel(
          id: 2,
          content: "wow mesaj",
          room: 1,
          author: (await UserTestService()
              .getItem(itemParameters: const ItemParameters()))!,
          read: false,
          dateTime: DateTime.now()),
      MessageModel(
          id: 3,
          content: "wow mesaj",
          room: 1,
          author: (await UserTestService()
              .getItem(itemParameters: const ItemParameters()))!,
          read: false,
          dateTime: DateTime.now()),
      MessageModel(
          id: 4,
          content: "wow mesaj",
          room: 1,
          author: (await UserTestService()
              .getItem(itemParameters: const ItemParameters()))!,
          read: false,
          dateTime: DateTime.now()),
      MessageModel(
          id: 5,
          content: "wow mesaj",
          room: 1,
          author: (await UserTestService()
              .getItem(itemParameters: const ItemParameters()))!,
          read: false,
          dateTime: DateTime.now()),
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
  Future<MessageModel?> postItem({required MessageModel item}) async {
    return item;
  }

  @override
  Future<bool?> reportItem(
      {required ItemParameters itemParameters, required String reason}) async {
    return true;
  }

  @override
  Future<MessageModel?> updateItem(
      {required MessageModel updatedItem,
      required ItemParameters itemParameters}) async {
    return updatedItem;
  }

  Stream<String> _timedMessageGenerator() async* {
    int i = 1000;
    while (true) {
      await Future.delayed(const Duration(seconds: 5));
      yield jsonEncode(MessageModel(
          id: i,
          content: "Message ${i++}",
          room: 1,
          author: const User(id: 2, email: "agubugu"),
          read: false,
          dateTime: DateTime.now()).toJson());
    }
  }

  @override
  void startStream() {
    protectedChatStream = _timedMessageGenerator().asBroadcastStream();
    super.startStream();
  }

  @override
  Future<bool?> readUnreadMessages({required User room}) async {
    return true;
  }
}
