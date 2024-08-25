import 'package:meta/meta.dart';
import 'package:campus_connect_frontend/utilities/filters/filters.dart';
import 'package:campus_connect_frontend/utilities/models/model.dart';

abstract class ModelService<T extends Model> {
  @protected
  bool hasNext = false;

  @protected
  bool canCallNext = false;

  @protected
  int pageIndex = 1;

  Future<List<T>?> getList({QueryParameters? queryParameters});

  Future<int?> getListCount({QueryParameters? queryParameters});

  Future<T?> postItem({required T item});

  Future<T?> getItem({required ItemParameters itemParameters});

  Future<bool?> deleteItem({required ItemParameters itemParameters});

  Future<T?> updateItem({required T updatedItem, required ItemParameters itemParameters});

  Future<bool?> hideItem({required ItemParameters itemParameters});

  Future<bool?> reportItem({required ItemParameters itemParameters, required String reason});

  bool next() {
    if (canCallNext && hasNext) {
      pageIndex++;
      canCallNext = false;
      return true;
    }
    return false;
  }

  void reset() {
    pageIndex = 1;
    hasNext = false;
    canCallNext = false;
  }
}
