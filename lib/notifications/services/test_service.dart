import 'package:campus_connect_frontend/notifications/notifications.dart';
import 'package:campus_connect_frontend/utilities/filters/item_paremeters.dart';
import 'package:campus_connect_frontend/utilities/filters/query_parameters.dart';
import 'package:campus_connect_frontend/utilities/models/model.dart';
import 'package:flutter/material.dart';

class NotificationTestService extends NotificationService {
  @override
  Future<bool?> deleteItem({required ItemParameters itemParameters}) async {
    return true;
  }

  @override
  Future<NotificationModel?> getItem({required ItemParameters itemParameters}) async {
    return (await getList())?.first;
  }

  @override
  Future<List<NotificationModel>?> getList({QueryParameters<Model>? queryParameters}) async {
    return const [
      NotificationModel(id: 1, title: "Notification 1", description: "Description", image: null),
      NotificationModel(id: 2, title: "Notification 2", description: "Description", image: null),
      NotificationModel(id: 3, title: "Notification 3", description: "Description", image: null),
      NotificationModel(id: 4, title: "Notification 4", description: "Description", image: null),
      NotificationModel(id: 5, title: "Notification 5", description: "Description", image: null),
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
  Future<NotificationModel?> postItem({required NotificationModel item}) async {
    return item;
  }

  @override
  Future<bool?> reportItem({required ItemParameters itemParameters, required String reason}) async {
    return true;
  }

  @override
  Future<NotificationModel?> updateItem({required NotificationModel updatedItem, required ItemParameters itemParameters}) async {
    return updatedItem;
  }

  
  @override
  // ignore: overridden_fields
  final unreadCount = ValueNotifier<int>(5);
    
}