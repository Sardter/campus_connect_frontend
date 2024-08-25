import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/material.dart';

abstract class BuilderPublisher<T extends Model>
    extends BuilderSegmentController<T> {
  BuilderWarningsController get warningsController;
  ModelService<T> get modelService;

  @override
  T? get data;

  bool get isUpdating;
  ItemParameters? get itemParameters;

  BuilderPublisher();

  Future<T?> publish() async {
    if (errorMesseges.isNotEmpty) {
      if (warningsController.onError != null) {
        for (var e in errorMesseges) {
          warningsController.onError!(e);
        }
      }
      //print("onpublishhh");
      return null;
    }
    //print("onpublishhh dataaaaaaaaaaaaa ${data!.toJson()}");
    return modelService.postItem(item: data!);
  }

  Future<T?> update() async {
    if (errorMesseges.isNotEmpty) {
      if (warningsController.onError != null) {
        for (var e in errorMesseges) {
          warningsController.onError!(e);
        }
      }
      print("onupdateee");
      return null;
    }
    print("onupdateee4");
    return modelService.updateItem(
        updatedItem: data!, itemParameters: itemParameters!);
  }

  List<MediaData?> get media;

  Future<T?> onDone() async {
    print("ondoneeeeee");
    return isUpdating ? await update() : await publish();
  }
}
