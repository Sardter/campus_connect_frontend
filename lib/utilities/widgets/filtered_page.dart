import 'package:flutter/material.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

enum FilteredPageMode { page, modal }

class FilteredPage<T extends Model> extends StatefulWidget {
  const FilteredPage(
      {Key? key,
      required this.manager,
      required this.mapper,
      this.header,
      this.queryParameters,
      this.searchable = false,
      this.mode = FilteredPageMode.page,
      this.title})
      : super(key: key);
  final Widget Function(T items) mapper;
  final ModelService<T> manager;
  final Widget? header;
  final QueryParameters? queryParameters;
  final String? title;
  final bool searchable;
  final FilteredPageMode mode;

  @override
  State<FilteredPage<T>> createState() => _FilteredPageState();
}

class _FilteredPageState<T extends Model> extends State<FilteredPage<T>> {
  final _searchController = TextEditingController();
  String? searchQuery;

  Future<List<Widget>> _getItems() async {
    return ((await widget.manager
                .getList(queryParameters: widget.queryParameters)) ??
            [])
        .map((e) => widget.mapper(e))
        .toList();
  }

  Widget _searchField() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: RoundedTextField(
          type: TextInputType.text,
          controller: _searchController,
          prefix: const [Icon(Icons.search), SizedBox(width: 10)],
          hint: "Ara",
          onChanged: (value) => setState(() {
                searchQuery = value.isEmpty ? null : value;
                _onRefresh();
              })),
    );
  }

  Future<List<Widget>?> _onRefresh() async {
    widget.manager.reset();

    final items = await _getItems();
    return [
      if (widget.header != null) widget.header!,
      if (widget.searchable) _searchField(),
      ...items
    ];
  }

  Future<List<Widget>?> _onLoad() async {
    if (!widget.manager.next()) return null;

    final items = await _getItems();
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return widget.mode == FilteredPageMode.page
        ? Scaffold(
            appBar: AppBar(),
            body: RefreshablePage(
              onRefresh: _onRefresh,
              onLoad: _onLoad,
            ),
          )
        : Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: RefreshablePage(
              onRefresh: _onRefresh,
              refreshOnce: true,
              onLoad: _onLoad,
            ),
          );
  }
}
