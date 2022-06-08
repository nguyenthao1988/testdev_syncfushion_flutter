import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:testdev/Datasource/EmployeeDataSource.dart';
import 'package:testdev/EventPage.dart';

import 'Model/Employee.dart';

void main() {
  runApp(const AppMain());
}

class AppMain extends StatelessWidget {
  const AppMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('vi'),
      ],
      locale: const Locale('vi'),
      theme: ThemeData().copyWith(
        primaryColor: Colors.green,
      ),
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Employee employee = Employee();
  final String URL_API = "https://raw.githubusercontent.com/dinhtona/api-mssql-dapper/main/db.json";
  final DataGridController _controller = DataGridController();
  List<Employee> _employees = <Employee>[];
  late EmployeeDataSource _employeeDataSource = EmployeeDataSource(employees: []);

  Future<List<Employee>> getDataEmployee() async {
    var dio = Dio();
    final response = await dio.get(URL_API);
    var listData = employee.listEmployeeFromJson(response.data);
    return listData;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataEmployee().then((value) {
      setState(() {
        _employees = value;
        _employeeDataSource = EmployeeDataSource(
          employees: _employees,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thảo Meo Demo GridView'),
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return SfDataGridTheme(
      data: SfDataGridThemeData(
        headerColor: const Color(0xff009889),
        selectionColor: const Color(0xff009889),
        frozenPaneLineWidth: 0,
        frozenPaneLineColor: Colors.red,
        sortIconColor: Colors.white,
        // gridLineColor: Colors.blueGrey,
      ),
      child: SfDataGrid(
        source: _employeeDataSource,
        selectionMode: SelectionMode.single,
        columnWidthMode: ColumnWidthMode.fitByCellValue,
        controller: _controller,
        allowSorting: true,
        allowMultiColumnSorting: false,
        frozenColumnsCount: 1,
        footerHeight: 60.0,
        footerFrozenRowsCount: 1,
        gridLinesVisibility: GridLinesVisibility.both,
        headerGridLinesVisibility: GridLinesVisibility.both,
        footer: Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 82.0),
                  child: SizedBox(
                      child: Text(
                    'Tổng số: ${_employees.length} em.',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff009889)),
                  )),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff009889),
                      ),
                      onPressed: () {
                        //_controller.scrollToRow(0, canAnimate: true);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const EventPage()));
                      },
                      label: Text(
                        'Lên đỉnh',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      icon: Icon(
                        Icons.arrow_upward_sharp,
                        color: Colors.white,
                        size: 28,
                      )),
                )
              ],
            )),
        columns: [
          GridColumn(
              width: 60,
              columnName: 'id',
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.center,
                  child: Text(
                    'ID',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ))),
          GridColumn(
              width: 150,
              columnName: 'name',
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Họ tên',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ))),
          GridColumn(
              width: 80,
              columnName: 'age',
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Tuổi',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ))),
          GridColumn(
              width: 110,
              columnName: 'birthPlace',
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Nơi sinh',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ))),
          GridColumn(
              columnName: 'address',
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Địa chỉ',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ))),
        ],
      ),
    );
  }
}
