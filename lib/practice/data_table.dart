import 'package:flutter/material.dart';

class DataTableScreen extends StatelessWidget {
  const DataTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text("data table"),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  const DataColumn(
                    label: Text(""),
                  ),
                  for (var x in _columnList.skip(1))
                    DataColumn(
                      label: Text(x),
                    ),
                ],
                rows: [
                  for (var i = 0; i < 20; i++)
                    DataRow(
                      cells: [
                        for (var x in _rowList)
                          DataCell(
                            Text(x),
                          ),
                      ],
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final List<String> _columnList =
    List.generate(10, (index) => "column #${index.toString()}");
final List<String> _rowList =
    List.generate(10, (index) => "row #${index.toString()}");
