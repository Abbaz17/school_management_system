import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for FilteringTextInputFormatter
import 'package:http/http.dart' as http;

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController rollController = TextEditingController();
  var message = "";
  var messageColor = Colors.black;
  bool showPassword = false;
  bool showConfirmPassword = false;

  Future<void> signUp() async {
    try {
      // Validate fields
      if (_validateFields()) {
        final response = await http.post(
          Uri.parse("http://localhost:3000/api/addUser"),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "username": usernameController.text,
            "password": passwordController.text,
            "roll": rollController.text,
          }),
        );
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          setState(() {
            message = data['message'];
            messageColor = Colors.green;
          });
          clearForm();
        } else {
          final data = json.decode(response.body);
          setState(() {
            message = data['message'];
            messageColor = Colors.red;
          });
        }
      }
    } catch (e) {
      print(e);
    }
  }

  bool _validateFields() {
    if (usernameController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmController.text.isEmpty ||
        rollController.text.isEmpty) {
      // Display a message indicating the empty field
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields'),
          duration: Duration(seconds: 2),
        ),
      );
      return false;
    } else if (passwordController.text != confirmController.text) {
      // Display a message indicating password mismatch
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Passwords do not match'),
          duration: Duration(seconds: 2),
        ),
      );
      return false;
    }
    return true;
  }

  // Function to clear form fields
  void clearForm() {
    usernameController.clear();
    passwordController.clear();
    confirmController.clear();
    rollController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Registration',
          style: TextStyle(color: Colors.black, fontSize: 30),
        ),
        centerTitle: true,
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
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  message,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat",
                    color: messageColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              _buildTextField("Username", usernameController),
              SizedBox(height: 10),
              _buildPasswordField("Password", passwordController, showPassword),
              SizedBox(height: 10),
              _buildPasswordField("Confirm Password", confirmController, showConfirmPassword),
              SizedBox(height: 10),
              _buildTextField("Role", rollController),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  signUp();
                },
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
      border: OutlineInputBorder(),
    ),
    inputFormatters: [
      FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z][a-zA-Z0-9]*$')),
    ],
  );
}


  Widget _buildPasswordField(String label, TextEditingController controller, bool show) {
    return TextField(
      controller: controller,
      obscureText: !show,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(show ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              if (label == "Password") {
                showPassword = !showPassword;
              } else if (label == "Confirm Password") {
                showConfirmPassword = !showConfirmPassword;
              }
            });
          },
        ),
      ),
    );
  }
}
