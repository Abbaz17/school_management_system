import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class StudentReportScreen extends StatefulWidget {
  @override
  _StudentReportScreenState createState() => _StudentReportScreenState();
}

class _StudentReportScreenState extends State<StudentReportScreen> {
  TextEditingController dayController = TextEditingController();

  Future<List<Map<String, dynamic>>> getStudentReportByDay() async {
    try {
      final response = await http.post(
        Uri.parse("http://localhost:3000/api/getStdReportByday"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'DDAY': dayController.text,
        }),
      );
      if (response.statusCode == 200) {
        final List<dynamic> reportData = json.decode(response.body);
        return List<Map<String, dynamic>>.from(reportData);
      } else {
        final data = json.decode(response.body);
        // Handle error or show a message
        return [];
      }
    } catch (e) {
      print(e);
      // Handle error or show a message
      return [];
    }
  }

  Future<void> printStudentReport(List<Map<String, dynamic>> report) async {
    final pdf = await generatePdf(report);

    await Printing.layoutPdf(
      onLayout: (format) async => pdf,
    );
  }

  Future<Uint8List> generatePdf(List<Map<String, dynamic>> report) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Table.fromTextArray(
            context: context,
            data: [
              ['Student ID', 'Student Name', 'Location', 'Age', 'Faculty', 'Class', 'Parent ID'],
              for (final row in report)
                [row['stdId'], row['stdName'], row['stdLocation'], row['stdAge'], row['stdFoculty'], row['stdClass'], row['parentId']],
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text('Student Report'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: dayController,
              decoration: InputDecoration(
                labelText: 'Enter day for filtering',
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                    primary: Colors.brown, // Background color
                    elevation: 5.0, // Elevation value
                  ),
              onPressed: () {
                setState(() {});
              },
              child: Text('Get Report'),
            ),
            const SizedBox(height: 20),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: getStudentReportByDay(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError || snapshot.data == null) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: [
                        DataColumn(label: Text('Student ID')),
                        DataColumn(label: Text('Student Name')),
                        DataColumn(label: Text('Location')),
                        DataColumn(label: Text('Age')),
                        DataColumn(label: Text('Faculty')),
                        DataColumn(label: Text('Class')),
                        DataColumn(label: Text('Day')),
                      ],
                      rows: snapshot.data!.map<DataRow>((report) {
                        return DataRow(
                          cells: [
                            DataCell(Text(report['stdId'].toString())),
                            DataCell(Text(report['stdName'].toString())),
                            DataCell(Text(report['stdLocation'].toString())),
                            DataCell(Text(report['stdAge'].toString())),
                            DataCell(Text(report['stdFoculty'].toString())),
                            DataCell(Text(report['stdClass'].toString())),
                            DataCell(Text(report['DDAY'].toString())),
                          ],
                        );
                      }).toList(),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                    primary: Colors.brown, // Background color
                    elevation: 5.0, // Elevation value
                  ),
              onPressed: () async {
                final report = await getStudentReportByDay();
                await printStudentReport(report);
              },
              child: Text('Print Report'),
            ),
          ],
        ),
      ),
    );
  }
}
