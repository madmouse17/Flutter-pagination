import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:latihan_pagination/Controller/TodosController.dart';
import 'package:latihan_pagination/models/todosModels.dart';

class infinity_scroll extends StatefulWidget {
  const infinity_scroll({Key? key}) : super(key: key);

  @override
  _infinity_scrollState createState() => _infinity_scrollState();
}

class _infinity_scrollState extends State<infinity_scroll> {
  static const _pageSize = 10;

  final PagingController<int, TodosModels> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await todosController.getScroll(pageKey, _pageSize);

      final isLastPage = newItems!.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => Future.sync(
          () => _pagingController.refresh(),
        ),
        child: PagedListView<int, TodosModels>.separated(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<TodosModels>(
              animateTransitions: true,
              itemBuilder: (context, item, index) => bot(context, item.title)),
          separatorBuilder: (context, index) => const Divider(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget bot(BuildContext context, value) => ListTile(
        title: Text(value),
      );
}
