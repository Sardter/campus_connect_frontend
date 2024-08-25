import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:campus_connect_frontend/utilities/services/theme.dart';

class RefreshablePageController<T extends Widget> {
  final items = ValueNotifier<List<T>>([]);
}

class RefreshablePage<T extends Widget> extends StatefulWidget {
  const RefreshablePage(
      {Key? key,
      this.onRefresh,
      this.onLoad,
      this.refreshOnce = false,
      this.shrinkWrap = false,
      this.emptyBuilder,
      this.pageController,
      this.headerBuilder})
      : super(key: key);
  final Future<List<T>?> Function()? onRefresh;
  final Future<List<T>?> Function()? onLoad;
  final bool refreshOnce;
  final bool shrinkWrap;
  final Widget Function(BuildContext context)? emptyBuilder;
  final Widget Function(BuildContext context)? headerBuilder;
  final RefreshablePageController<T>? pageController;

  @override
  State<RefreshablePage<T>> createState() => RefreshablePageState<T>();
}

class RefreshablePageState<T extends Widget>
    extends State<RefreshablePage<T>> {
  final controller = RefreshController(initialRefresh: true);
  late final _pageController =
      widget.pageController ?? RefreshablePageController();
  bool _refreshed = false;

  void onRefresh() async {
    final items = await widget.onRefresh!();

    if (items == null) {
      controller.refreshFailed();
    } else {
      _refreshed = true;
      _pageController.items.value = items;
      controller.refreshCompleted();
    }
  }

  void onLoad() async {
    final items = await widget.onLoad!();

    if (items == null) {
      controller.loadFailed();
    } else {
      _pageController.items.value += items;
      controller.loadComplete();
    }
  }

  int get _headerValue => widget.headerBuilder == null ? 0 : 1;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<T>>(
      valueListenable: _pageController.items,
      builder: (context, value, child) => SmartRefresher(
        onRefresh: widget.onRefresh != null ? onRefresh : null,
        onLoading: widget.onLoad != null ? onLoad : null,
        enablePullUp: widget.onLoad != null,
        enablePullDown:
            widget.onRefresh != null && !(widget.refreshOnce && _refreshed),
        controller: controller,
        header: const WaterDropMaterialHeader(
          backgroundColor: ThemeService.eventColor,
        ),
        footer: CustomFooter(
          builder: (context, mode) {
            return const SizedBox(
              width: 50,
              height: 50,
              child: Center(
                child: CircularProgressIndicator(
                  color: ThemeService.disabledColor,
                ),
              ),
            );
          },
        ),
        child: value.isEmpty &&
                widget.emptyBuilder != null &&
                widget.headerBuilder == null
            ? widget.emptyBuilder!(context)
            : ListView.builder(
                shrinkWrap: widget.shrinkWrap,
                itemBuilder: (context, index) => _headerValue == 1 && index == 0
                    ? widget.headerBuilder!(context)
                    : value[index - _headerValue],
                itemCount: value.length + _headerValue,
              ),
      ),
    );
  }
}
