import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ParentsScreen extends StatefulWidget {
  @override
  _ParentsScreenState createState() => _ParentsScreenState();
}

class _ParentsScreenState extends State<ParentsScreen> {
  Future<List<Map<String, dynamic>>> getAllParents() async {
    try {
      final response = await http.get(
        Uri.parse("http://localhost:3000/api/allParents"),
      );
      if (response.statusCode == 200) {
        final List<dynamic> parentsData = json.decode(response.body);
        return List<Map<String, dynamic>>.from(parentsData);
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
        title: Text('Parents List'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getAllParents(),
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
                DataColumn(label: Text('parentID')),
                DataColumn(label: Text('parentName')),
                DataColumn(label: Text('parentPhone')),

              ],
              rows: snapshot.data!.map<DataRow>((parent) {
                return DataRow(
                  cells: [
                    DataCell(Text(parent['parentId'].toString())),
                    DataCell(Text(parent['parentName'].toString())),
                    DataCell(Text(parent['parentNum'].toString())),
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
