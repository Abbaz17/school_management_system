import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:school_app/screens/dashboard.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    TextEditingController passwordController = TextEditingController();
    TextEditingController usernameController = TextEditingController();
    Future<void> login() async {
      try {
        final response = await http.post(
            Uri.parse("http://localhost:3000/api/login"),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              "username": usernameController.text,
              "password": passwordController.text
            }));
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          print(data['message']);
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => Dashboard()));
        } else {
          final data = json.decode(response.body);
          print(data['message']);
        }
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(
      backgroundColor: Color(0xff9C27B0),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Icon(
              Icons.lock_open_outlined,
              size: 110,
              color: Color(0xff009688),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Enter your username",
                labelText: "Username",
                labelStyle: TextStyle(color: Colors.white),
                hintStyle: TextStyle(color: Colors.white54),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              style: TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              controller: usernameController,
              onSubmitted: (val) {
                print(val);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Enter your password",
                labelText: "Password",
                labelStyle: TextStyle(color: Colors.white),
                hintStyle: TextStyle(color: Colors.white54),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              obscureText: true,
              style: TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              onSubmitted: (val) {
                print(val);
              },
              controller: passwordController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: () {
                login();
              },
              icon: Icon(Icons.key),
              label: Text(
                "Login",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff009688),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            ),
          ),
          const SizedBox(height: 15,) ,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("don`t have account?",style: TextStyle(
                color: Colors.white
              ),),
              TextButton(
                onPressed: () {},
                 child: Text("signup" ,style: TextStyle(
                  color: Color(0xff009688) ,
                  fontSize: 18
                 ),),
                 ),
            ],
          )
        ],
      ),
    );
  }
}
