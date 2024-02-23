import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class StudentListScreen extends StatefulWidget {
  @override
  _StudentListScreenState createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  Future<List<Map<String, dynamic>>> getAllStudents() async {
    try {
      final response = await http.get(
        Uri.parse("http://localhost:3000/api/allStd"),
      );
      if (response.statusCode == 200) {
        final List<dynamic> studentsData = json.decode(response.body);
        return List<Map<String, dynamic>>.from(studentsData);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text('Student List'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getAllStudents(),
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
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Location')),
                  DataColumn(label: Text('Age')),
                  DataColumn(label: Text('Faculty')),
                  DataColumn(label: Text('Class')),
                  DataColumn(label: Text('DDAY')),
                ],
                rows: snapshot.data!.map<DataRow>((student) {
                  return DataRow(
                    cells: [
                      DataCell(Text(student['stdId'].toString())),
                      DataCell(Text(student['stdName'].toString())),
                      DataCell(Text(student['stdLocation'].toString())),
                      DataCell(Text(student['stdAge'].toString())),
                      DataCell(Text(student['stdFoculty'].toString())),
                      DataCell(Text(student['stdClass'].toString())),
                      DataCell(Text(student['DDAY'].toString())),
                    ],
                  );
                }).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
