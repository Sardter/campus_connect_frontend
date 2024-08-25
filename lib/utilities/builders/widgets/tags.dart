import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

class EdittableTags extends StatefulWidget {
  const EdittableTags(
      {Key? key,
      required this.controller,
      this.showTitle = true,
      this.editable = true,
      this.onChanged,
      this.onTagSearch})
      : super(key: key);
  final bool showTitle;
  final bool editable;
  final Future<List<String>?> Function(String searchToken)? onTagSearch;
  final void Function(List<String>)? onChanged;

  @override
  State<EdittableTags> createState() => EdittableTagsState();

  final EditableTagsController controller;
}

class EdittableTagsState extends State<EdittableTags> {
  final TextEditingController _controller = TextEditingController();
  List<String> _searchedTags = [];
  bool _isLoading = false;

  void onDelete(int index) {
    if (widget.controller.tags.isNotEmpty) {
      widget.controller.tags.removeAt(index);
    }

    if (mounted) setState(() {});
    if (widget.onChanged != null) widget.onChanged!(widget.controller.tags);
  }

  Future<void> _search(String searchToken) async {
    _isLoading = true;
    setState(() {});
    _searchedTags = widget.onTagSearch == null
        ? []
        : await widget.onTagSearch!(searchToken) ?? [];

    _isLoading = false;
    setState(() {});
  }

  Widget _addTag() {
    return InkWell(
      onTap: () {
        if (_controller.text.isNotEmpty) {
          if (_controller.text.length > 50) {
            return;
          }
          setState(() {
            widget.controller.tags.add(_controller.text);
          });
          _controller.clear();
          if (widget.onChanged != null) {
            widget.onChanged!(widget.controller.tags);
          }
        }
      },
      child: const Icon(LineIcons.plus),
    );
  }

  Widget _field() {
    return RoundedTextField(
      type: TextInputType.text,
      controller: _controller,
      hint: "Add Tag",
      onChanged: _search,
      suffix: [_addTag()],
    );
  }

  List<Widget> _header() {
    return const [
      Text("Tags",
          style:
              TextStyle(fontSize: 17, fontFamily: ThemeService.headlineFont)),
      Divider(),
      SizedBox(height: 5),
    ];
  }

  Widget _searchedTag(String tag) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.controller.tags.add(tag);
          _searchedTags.clear();
          _controller.clear();
        });
      },
      child: ListTile(
        leading: const Icon(LineIcons.hashtag),
        title: Text(tag),
      ),
    );
  }

  Widget _searchPannel() {
    return _isLoading
        ? const LoadingIndicator()
        : Column(
            children: _searchedTags.map((e) => _searchedTag(e)).toList(),
          );
  }

  Widget _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.showTitle) ..._header(),
        _field(),
        if (_searchedTags.isNotEmpty) _searchPannel(),
        TagsWidget(
          tags: widget.controller.tags,
          onDelete: onDelete,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _body();
  }
}
