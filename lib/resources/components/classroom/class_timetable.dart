import 'package:flutter/material.dart';

class TimeTable extends StatelessWidget {
  final classTime = ['9:10-10', '11-12'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const <DataColumn>[
            DataColumn(
              label: Text('Day'),
            ),
            DataColumn(
              label: Text('Time'),
            ),
            DataColumn(
              label: Text('Room Number'),
            ),
          ],
          rows: <DataRow>[
            DataRow(
              cells: <DataCell>[
                const DataCell(Text('Monday')),
                DataCell(
                  Text('25'),
                  onTap: () {
                    _showDialog(context, 'Monday');
                  },
                ),
                const DataCell(Text('New York')),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                const DataCell(Text('Tuesday')),
                DataCell(
                  Text(classTime.toString()),
                  onTap: () {
                    _showDialog(context, 'Tuesday');
                  },
                ),
                const DataCell(Text('Los Angeles')),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('Wednesday')),
                DataCell(
                  Text('22'),
                  onTap: () {
                    _showDialog(context, 'Wednesday');
                  },
                ),
                DataCell(Text('Chicago')),
              ],
            ),
            const DataRow(
              cells: <DataCell>[
                DataCell(Text('Thursday')),
                DataCell(Text('22')),
                DataCell(Text('Chicago')),
              ],
            ),
            const DataRow(
              cells: <DataCell>[
                DataCell(Text('Friday')),
                DataCell(Text('22')),
                DataCell(Text('Chicago')),
              ],
            ),
            const DataRow(
              cells: <DataCell>[
                DataCell(Text('Saturday')),
                DataCell(Text('22')),
                DataCell(Text('Chicago')),
              ],
            ),
            const DataRow(
              cells: <DataCell>[
                DataCell(Text('Sunday')),
                DataCell(Text('22')),
                DataCell(Text('Chicago')),
              ],
            ),
            // Add more rows as needed
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context, String day) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Time for $day'),
          content: Text(classTime[0] ?? 'No time specified'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
