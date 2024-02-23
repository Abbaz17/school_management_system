import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class TeacherRegistration extends StatefulWidget {
  @override
  _TeacherRegistrationState createState() => _TeacherRegistrationState();
}

class _TeacherRegistrationState extends State<TeacherRegistration> {
  TextEditingController tIdController = TextEditingController();
  TextEditingController tNameController = TextEditingController();
  TextEditingController tLocationController = TextEditingController();
  TextEditingController tFacultyController = TextEditingController();
  TextEditingController dOfDayController = TextEditingController();

  // Function to add a new teacher
  Future<void> addTeacher() async {
    try {
      // Check if any of the fields is empty
      if (tIdController.text.isEmpty ||
          tNameController.text.isEmpty ||
          tLocationController.text.isEmpty ||
          tFacultyController.text.isEmpty ||
          dOfDayController.text.isEmpty) {
        // Display a message indicating the empty field
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please fill in all fields'),
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }

      final response = await http.post(
        Uri.parse("http://localhost:3000/api/addTeacher"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "tId": tIdController.text,
          "tName": tNameController.text,
          "tLocation": tLocationController.text,
          "tFoculty": tFacultyController.text,
          "dOfDay": dOfDayController.text,
        }),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['message']),
            duration: Duration(seconds: 2),
          ),
        );
        clearForm();
      } else {
        final data = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['message']),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  // Function to delete a teacher
  Future<void> deleteTeacher(String teacherId) async {
    try {
      final response = await http.delete(
        Uri.parse("http://localhost:3000/api/deleteTeacher/$teacherId"),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['message']),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        final data = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['message']),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  // Function to update teacher information
  Future<void> updateTeacher() async {
    try {
      final response = await http.put(
        Uri.parse("http://localhost:3000/api/updateTeacher"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "tId": tIdController.text,
          "tName": tNameController.text,
          "tLocation": tLocationController.text,
          "tFoculty": tFacultyController.text,
          "dOfDay": dOfDayController.text,
        }),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['message']),
            duration: Duration(seconds: 2),
          ),
        );
        clearForm();
      } else {
        final data = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['message']),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  // Function to load teacher data
  Future<void> loadTeacherDataById(TextEditingController tIdController) async {
    try {
      final String teacherId = tIdController.text;

      final response = await http.get(
        Uri.parse("http://localhost:3000/api/getTeachersById/$teacherId"),
      );
      if (response.statusCode == 200) {
        final List<dynamic> teacherDataList = json.decode(response.body);

        if (teacherDataList.isNotEmpty) {
          // Assuming there is at least one teacher in the response
          final Map<String, dynamic> teacherData = teacherDataList.first;

          // Populate text fields with data
          tIdController.text = teacherData['tId'].toString();
          tNameController.text = teacherData['tName'].toString();
          tLocationController.text = teacherData['tLocation'].toString();
          tFacultyController.text = teacherData['tFoculty'].toString();
          dOfDayController.text = teacherData['dOfDay'].toString();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Data loaded successfully'),
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('No data found for the specified ID'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      } else {
        final data = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['message']),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  // Function to clear form fields
  void clearForm() {
    tIdController.clear();
    tNameController.clear();
    tLocationController.clear();
    tFacultyController.clear();
    dOfDayController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text('Teacher Registration Form'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              "https://images.unsplash.com/photo-1556740714-a8395b3bf30f?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8cmVnaXN0ZXJ8ZW58MHx8MHx8fDA%3D",
            ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.3),
              BlendMode.dstATop,
            ),
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildTextField('Teacher ID', tIdController),
            buildTextField('Teacher Name', tNameController),
            buildTextField('Teacher Location', tLocationController),
            buildTextField('Teacher Faculty', tFacultyController),
            buildTextField('Day of Duty', dOfDayController),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.brown, // Background color
                    elevation: 5.0, // Elevation value
                  ),
                  onPressed: addTeacher,
                  child: Text('Add'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.brown, // Background color
                    elevation: 5.0, // Elevation value
                  ),
                  onPressed: () {
                    deleteTeacher(tIdController.text);
                    clearForm();
                  },
                  child: Text('Delete'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.brown, // Background color
                    elevation: 5.0, // Elevation value
                  ),
                  onPressed: updateTeacher,
                  child: Text('Update'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.brown, // Background color
                    elevation: 5.0, // Elevation value
                  ),
                  onPressed: () {
                    loadTeacherDataById(tIdController);
                  },
                  child: Text('Load'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        controller: controller,
        inputFormatters: label == 'Teacher ID'
            ? [] // No input formatter for Teacher ID
            : [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]'))],
      ),
    );
  }
}
