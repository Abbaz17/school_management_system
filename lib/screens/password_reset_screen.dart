import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({super.key});

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final _emailController = TextEditingController();

  bool isLoading = false;

  // Clear field
  void clearField() {
    _emailController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock_reset,
                  size: 100,
                  color: Colors.brown,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Reset",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Reset with email",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: "E-mail",
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.brown,
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () async {
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      // Reset password
                      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text);

                      // Show success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.brown,
                          content: Text("Password reset link is sent !" + _emailController.text),
                        ),
                      );

                      clearField();
                    } catch (error) {
                      // Show error message
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(error.toString())));
                    } finally {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  child: Container(
                      margin:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.brown,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Center(
                          child: isLoading
                              ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                              : Text(
                            "Reset",
                            style: TextStyle(
                                color: Colors.white, fontSize: 22),
                          ))),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
