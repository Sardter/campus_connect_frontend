import 'package:campus_connect_frontend/home/home.dart';
import 'package:campus_connect_frontend/modals/modals.dart';
import 'package:campus_connect_frontend/posts/posts.dart';
import 'package:campus_connect_frontend/users/users.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_segment/flutter_advanced_segment.dart';

class TabData {
  final String title;
  final ModelService<Post> service;

  const TabData({required this.title, required this.service});
}

class FilteredPosts extends StatefulWidget {
  const FilteredPosts(
      {super.key, required this.filtersController, this.author});
  final FiltersController filtersController;
  final User? author;

  @override
  State<FilteredPosts> createState() => _FilteredPostsState();
}

class _FilteredPostsState extends State<FilteredPosts> {
  final _tabValue = ValueNotifier('second');
  final _refreshKey = GlobalKey<RefreshablePageState>();
  final _searchController = TextEditingController();
  final _tabsData = {
    'second': TabData(
        title: 'Second Hand', service: ServiceFactory.secondHandService),
    'borrow':
        TabData(title: 'Borrow', service: ServiceFactory.borrowableService),
    'donate': TabData(title: 'Donate', service: ServiceFactory.donationService),
    'lost': TabData(
        title: 'Lost And Found', service: ServiceFactory.lostAndFoundService)
  };

  PostType _getPostType() {
    switch (_tabValue.value) {
      case 'second':
        return PostType.shs;
      case 'borrow':
        return PostType.brw;
      case 'donate':
        return PostType.dnt;
      case 'lost':
        return PostType.laf;
      default:
        throw UnimplementedError();
    }
  }

  String get _searchQuery => _searchController.text;
  PostQueryParameters get _queryParameters => PostQueryParameters(
      searchQuery: _searchQuery,
      author: widget.author,
      course: widget.filtersController.course.value,
      postType: _getPostType(),
      subject: widget.filtersController.subject.value);

  @override
  void initState() {
    super.initState();

    _tabValue.addListener(() {
      _refreshKey.currentState?.onRefresh();
    });

    widget.filtersController.onToggle = () {
      _onFilter();
    };
  }

  Future<List<Widget>?> _onRefresh() async {
    final tabData = _tabsData[_tabValue.value];

    if (tabData == null) return null;

    tabData.service.reset();

    final posts =
        await tabData.service.getList(queryParameters: _queryParameters);

    return posts?.map((e) => PostWidget(post: e)).toList();
  }

  Future<List<Widget>?> _onLoad() async {
    final tabData = _tabsData[_tabValue.value];

    if (tabData == null) return null;

    if (!tabData.service.next()) return null;

    final posts =
        await tabData.service.getList(queryParameters: _queryParameters);

    return posts?.map((e) => PostWidget(post: e)).toList();
  }

  void _onFilter() {
    _refreshKey.currentState?.onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshablePage(
      key: _refreshKey,
      headerBuilder: (context) => Container(
          margin: EdgeInsets.symmetric(
              vertical: 10, horizontal: getResponsiveMarginWidth(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AdvancedSegment(
                controller: _tabValue,
                borderRadius: ThemeService.allAroundBorderRadius,
                backgroundColor: ThemeService.textField,
                segments:
                    _tabsData.map((key, value) => MapEntry(key, value.title)),
              ),
              const SizedBox(height: 10),
              RoundedTextField(
                type: TextInputType.text,
                prefix: const [Icon(Icons.search), SizedBox(width: 5)],
                controller: _searchController,
                onChanged: (value) {
                  _onFilter();
                },
                hint: "Ara",
              ),
              const SizedBox(height: 10),
              SocialUtilButton(
                  children: const [Text("Filters")],
                  onTap: () async {
                    launchModal(context,
                        FiltersVierw(controller: widget.filtersController));
                    return false;
                  })
            ],
          )),
      onRefresh: _onRefresh,
      onLoad: _onLoad,
    );
  }
}
