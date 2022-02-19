import 'package:flutter/material.dart';
import 'package:latihan_pagination/Controller/TodosController.dart';
import 'package:latihan_pagination/models/todosModels.dart';
import 'package:http/http.dart' as http;

class ResultsDataSource extends DataTableSource {
  final List<TodosModels>? _results;
  ResultsDataSource(this._results);

  int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _results!.length) return null;
    final TodosModels result = _results![index];
    return DataRow.byIndex(index: index, cells: <DataCell>[
      DataCell(Text('${result.id}'), onTap: () {
        print("test");
      }),
      DataCell(Text('${result.title}')),
    ]);
  }

  @override
  int get rowCount => _results!.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

class tablePagination extends StatefulWidget {
  const tablePagination({Key? key}) : super(key: key);

  @override
  _tablePaginationState createState() => _tablePaginationState();
}

class _tablePaginationState extends State<tablePagination> {
  ResultsDataSource _resultsDataSource = ResultsDataSource([]);

  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    final results = await todosController.getTodos(http.Client());
    setState(() {
      _resultsDataSource = ResultsDataSource(results);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
              child: Container(
                  child: PaginatedDataTable(
        rowsPerPage: _rowsPerPage,

        // ignore: prefer_const_constructors
        columns: [
          DataColumn(label: Text("id")),
          DataColumn(label: Text("Title"))
        ],
        source: _resultsDataSource,
        //   rows: data!
        //       .map((e) => DataRow(
        //             cells: [
        //               DataCell(Text("${e.id}")),
        //               DataCell(Text(e.title))
        //             ],
        //           ))
        //       .toList(),
        // ),
      )))),
    );
  }
}
