import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TeacherList extends StatefulWidget {
  @override
  _TeacherListState createState() => _TeacherListState();
}

class _TeacherListState extends State<TeacherList> {
  Future<List<Map<String, dynamic>>> getAllTeachers() async {
    try {
      final response = await http.get(
        Uri.parse("http://localhost:3000/api/allTeachers"),
      );
      if (response.statusCode == 200) {
        final List<dynamic> teachersData = json.decode(response.body);
        return List<Map<String, dynamic>>.from(teachersData);
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
        backgroundColor: Colors.brown.shade400,
        title: Text('Teachers List'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getAllTeachers(),
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
            return DataTable(
              columns: [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Location')),
                DataColumn(label: Text('Faculty')),
                DataColumn(label: Text('DDay')),
              ],
              rows: snapshot.data!.map<DataRow>((teacher) {
                return DataRow(
                  cells: [
                    DataCell(Text(teacher['tId'].toString())),
                    DataCell(Text(teacher['tName'].toString())),
                    DataCell(Text(teacher['tLocation'].toString())),
                    DataCell(Text(teacher['tFoculty'].toString())),
                    DataCell(Text(teacher['dOfDay'].toString())),
                  ],
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
