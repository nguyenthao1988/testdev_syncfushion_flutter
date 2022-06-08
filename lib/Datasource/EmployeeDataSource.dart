import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:testdev/Model/Employee.dart';

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource({required List<Employee> employees}) {
    dataGridRows = employees
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: dataGridRow.id),
              DataGridCell<String>(columnName: 'name', value: dataGridRow.name),
              DataGridCell<int>(columnName: 'age', value: dataGridRow.age),
              DataGridCell<String>(columnName: 'birthPlace', value: dataGridRow.birthPlace),
              DataGridCell<String>(columnName: 'address', value: dataGridRow.address),
            ]))
        .toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      Color getColor() {
        if (dataGridCell.columnName == 'birthPlace') {
          if (dataGridCell.value == 'Trung Quốc') {
            return Colors.tealAccent;
          } else if (dataGridCell.value == 'Campuchia') {
            return Colors.blue[200]!;
          }
        }

        return Colors.transparent;
      }

      TextStyle? getTextStyle() {
        if (dataGridCell.columnName == 'birthPlace') {
          if (dataGridCell.value == 'Trung Quốc') {
            return TextStyle(fontStyle: FontStyle.italic);
          } else if (dataGridCell.value == 'Campuchia') {
            return TextStyle(fontStyle: FontStyle.italic);
          }
        }

        return null;
      }

      return Container(
          //color: getColor(),
          alignment: (dataGridCell.columnName == 'id' || dataGridCell.columnName == 'age')
              ? Alignment.center
              : Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            dataGridCell.value.toString(),
            // style: getTextStyle(),
          ));
    }).toList());
  }

  @override
  bool shouldRecalculateColumnWidths() {
    return true;
  }
}
