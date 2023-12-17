import 'dart:convert';

import 'package:flutter/material.dart';
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

  Future<void> signUp() async {
    try {
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
          messageColor=Colors.green ;
        });
      } else {
        final data = json.decode(response.body);
        setState(() {
          message = data['message'];
          messageColor = Colors.red ;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Registration' ,style: TextStyle(
          color: Colors.black ,
          fontSize: 30
        ),),
        centerTitle: true,
      ),
      
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage("https://images.unsplash.com/photo-1556740714-a8395b3bf30f?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8cmVnaXN0ZXJ8ZW58MHx8MHx8fDA%3D" ,
          ),
          fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.3), // Replace with your desired color and opacity
              BlendMode.dstATop, // Change the blend mode as needed
            ),

          )
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(message ,style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Montserrat",
                  color: messageColor
                ),),
              ),
              const SizedBox(height: 10,) ,
              _buildTextField("Username", usernameController),
              SizedBox(height: 10),
              _buildTextField("Password", passwordController, isPassword: true),
              SizedBox(height: 10),
              _buildTextField("Confirm Password", confirmController, isPassword: true),
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

  Widget _buildTextField(String label, TextEditingController controller, {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }
}
