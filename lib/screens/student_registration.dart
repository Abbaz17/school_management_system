import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class StudentRegistration extends StatefulWidget {
  @override
  _StudentRegistrationState createState() => _StudentRegistrationState();
}

class _StudentRegistrationState extends State<StudentRegistration> {
  TextEditingController stdIdController = TextEditingController();
  TextEditingController stdNameController = TextEditingController();
  TextEditingController stdLocationController = TextEditingController();
  TextEditingController stdAgeController = TextEditingController();
  TextEditingController stdFacultyController = TextEditingController();
  TextEditingController stdClassController = TextEditingController();
  TextEditingController parentIdController = TextEditingController();

  // Function to add a new student
  Future<void> addStd() async {
  try {
    // Check if any of the fields is empty
    if (stdIdController.text.isEmpty ||
        stdNameController.text.isEmpty ||
        stdLocationController.text.isEmpty ||
        stdAgeController.text.isEmpty ||
        stdFacultyController.text.isEmpty ||
        stdClassController.text.isEmpty ||
        parentIdController.text.isEmpty) {
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
      Uri.parse("http://localhost:3000/api/addStd"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "stdId": stdIdController.text,
        "stdName": stdNameController.text,
        "stdLocation": stdLocationController.text,
        "stdAge": stdAgeController.text,
        "stdFoculty": stdFacultyController.text,
        "stdClass": stdClassController.text,
        "DDAY": parentIdController.text
      }),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // print(data['message']);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(data['message']),
          duration: Duration(seconds: 2),
        ),
      );
      clearForm();
    } else {
      final data = json.decode(response.body);
      // print(data['message']);
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
Future<void> loadStudentDataById(TextEditingController stdIdController) async {
  try {
    final String studentId = stdIdController.text;

    final response = await http.get(
      Uri.parse("http://localhost:3000/api/getStudentById/$studentId"),
    );
    if (response.statusCode == 200) {
      final List<dynamic> studentDataList = json.decode(response.body);

      if (studentDataList.isNotEmpty) {
        // Assuming there is at least one student in the response
        final Map<String, dynamic> studentData = studentDataList.first;

        // Populate text fields with data
        stdIdController.text = studentData['stdId'].toString();
        stdNameController.text = studentData['stdName'].toString();
        stdLocationController.text = studentData['stdLocation'].toString();
        stdAgeController.text = studentData['stdAge'].toString();
        stdFacultyController.text = studentData['stdFoculty'].toString();
        stdClassController.text = studentData['stdClass'].toString();
        parentIdController.text = studentData['DDAY'].toString();

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


  // Function to update student information
  Future<void> updateStd() async {
  try {
    // Construct the request body as a JSON object
    final Map<String, dynamic> requestBody = {
      "stdId": stdIdController.text,
      "stdName": stdNameController.text,
      "stdLocation": stdLocationController.text,
      "stdAge": stdAgeController.text,
      "stdFoculty": stdFacultyController.text,
      "stdClass": stdClassController.text,
      "DDAY": parentIdController.text,
    };

    // Make the HTTP PUT request to update the student
    final response = await http.put(
      Uri.parse("http://localhost:3000/api/updateStd"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    // Check the response status code
    if (response.statusCode == 200) {
      // If successful, decode the response body
      final data = json.decode(response.body);
      
      // Show a success message in a SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(data['message']),
          duration: Duration(seconds: 2),
        ),
      );

      // Clear the form fields after a successful update
      clearForm();
    } else {
      // If the server returns an error, decode the response body
      final data = json.decode(response.body);
      
      // Show an error message in a SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(data['message']),
          duration: Duration(seconds: 2),
        ),
      );
    }
  } catch (e) {
    // Handle any exceptions that occur during the update process
    print(e);
  }
}

    // Function to delete a student

  Future<void> deleteStd() async {
  try {
    // Construct the request body as a JSON object
    final Map<String, dynamic> requestBody = {
      "stdId": stdIdController.text,
    };

    // Make the HTTP PUT request to update the student
    final response = await http.delete(
      Uri.parse("http://localhost:3000/api/deleteStd"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    // Check the response status code
    if (response.statusCode == 200) {
      // If successful, decode the response body
      final data = json.decode(response.body);
      
      // Show a success message in a SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(data['message']),
          duration: Duration(seconds: 2),
        ),
      );

      // Clear the form fields after a successful update
      clearForm();
    } else {
      // If the server returns an error, decode the response body
      final data = json.decode(response.body);
      
      // Show an error message in a SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(data['message']),
          duration: Duration(seconds: 2),
        ),
      );
    }
  } catch (e) {
    // Handle any exceptions that occur during the update process
    print(e);
  }
}



  // Function to clear form fields
  void clearForm() {
    stdIdController.clear();
    stdNameController.clear();
    stdLocationController.clear();
    stdAgeController.clear();
    stdFacultyController.clear();
    stdClassController.clear();
    parentIdController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Form'),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: NetworkImage(
            "https://images.unsplash.com/photo-1556740714-a8395b3bf30f?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8cmVnaXN0ZXJ8ZW58MHx8MHx8fDA%3D",
          ),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(
                0.3), // Replace with your desired color and opacity
            BlendMode.dstATop, // Change the blend mode as needed
          ),
        )),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              buildTextField('Student ID', stdIdController),
              buildTextField('Student Name', stdNameController),
              buildTextField('Student Location', stdLocationController),
              buildTextField('Student Age', stdAgeController),
              buildTextField('Student Faculty', stdFacultyController),
              buildTextField('Student Class', stdClassController),
              buildTextField('DDAY', parentIdController),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: addStd,
                    child: Text('Add'),
                  ),
                  ElevatedButton(
                    onPressed: deleteStd,
                    child: Text('Delete'),
                  ),
                  ElevatedButton(
                    onPressed: updateStd,
                    child: Text('Update'),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      loadStudentDataById(stdIdController) ;
                    },
                    child: Text('Load Data'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

Widget buildTextField(String label, TextEditingController controller) {
  // Define a regular expression for allowing only letters (including spaces)
  RegExp lettersOnlyWithSpaces = RegExp(r'^[a-zA-Z ]+$');

  // Use different inputFormatters based on the label
  List<TextInputFormatter> inputFormatters = [];
  if (label == 'Student Name' || label == 'Student Location' || label == 'Student Faculty' || label == 'DDAY' || label == 'Student Class') {
    inputFormatters = [FilteringTextInputFormatter.allow(lettersOnlyWithSpaces)];
  }

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: TextField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      controller: controller,
      inputFormatters: inputFormatters,
    ),
  );
}
}
