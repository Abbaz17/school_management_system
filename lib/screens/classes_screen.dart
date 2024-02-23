import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ClassesScreen extends StatefulWidget {
  @override
  _ClassesScreenState createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen> {
  Future<List<Map<String, dynamic>>> getAllClasses() async {
    try {
      final response = await http.get(
        Uri.parse("http://localhost:3000/api/allClasses"),
      );
      if (response.statusCode == 200) {
        final List<dynamic> classesData = json.decode(response.body);
        return List<Map<String, dynamic>>.from(classesData);
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
        title: Text('Classes List'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getAllClasses(),
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
                  DataColumn(label: Text('Class ID')),
                  DataColumn(label: Text('Class Name')),
                  DataColumn(label: Text('Class Faculty')),
                ],
                rows: snapshot.data!.map<DataRow>((classInfo) {
                  return DataRow(
                    cells: [
                      DataCell(Text(classInfo['classId'].toString())),
                      DataCell(Text(classInfo['className'].toString())),
                      DataCell(Text(classInfo['classFoculty'].toString())),
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