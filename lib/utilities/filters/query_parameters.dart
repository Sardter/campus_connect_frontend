import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/widgets.dart';

class QueryParameters<T extends Model> {
  final String? searchQuery;
  final int pageSize;
  final bool notHidden;
  final bool sorted;

  const QueryParameters(
      {required this.searchQuery,
      this.pageSize = 1000,
      this.notHidden = false,
      this.sorted = false});

  String fieldStringify<K>(K? field, String Function(K field) toStr) {
    if (field == null) return "";
    return toStr(field);
  }

  List<String?> get defaultFieldsToStr => [
        fieldStringify<String>(
            (searchQuery?.isEmpty ?? false) ? null : searchQuery,
            (field) => "search_text=$field"),
        fieldStringify<int>(pageSize, (field) => "page_size=$field"),
        fieldStringify<bool>(notHidden,
            (field) => "filter_mode=${!field ? 'regular' : 'hidden'}"),
        fieldStringify(
            sorted, (field) => "page_mode=${!field ? 'normal' : 'sorted'}"),
        ...fieldsToStr
      ];

  @protected
  List<String?> get fieldsToStr => [];

  @override
  String toString() {
    return defaultFieldsToStr
        .where((element) => element != null && element.isNotEmpty)
        .join('&');
  }
}
