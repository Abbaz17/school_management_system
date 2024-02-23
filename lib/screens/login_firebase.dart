// import 'package:ca206_ch6/screens/password_reset_screen.dart';
// import 'package:ca206_ch6/screens/register_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:school_app/screens/dashboard.dart';

import 'password_reset_screen.dart';
import 'register_firebase.dart';
// import 'firebase_options.dart';
class LoginScreenF extends StatefulWidget {
  const LoginScreenF({super.key});

  @override
  State<LoginScreenF> createState() => _LoginScreenFState();
}

class _LoginScreenFState extends State<LoginScreenF> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isHidden = true;
  bool isLoading = false;

  // Clear fields
  void clearFields() {
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
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
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lock,
                    size: 100,
                    color: Colors.brown,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Login",
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Login with email and password",
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
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: isHidden,
                      decoration: InputDecoration(
                        hintText: "**********",
                        prefixIcon: Icon(
                          Icons.vpn_key,
                          color: Colors.brown,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isHidden = !isHidden;
                            });
                          },
                          icon: isHidden
                              ? Icon(Icons.visibility, color: Colors.brown)
                              : Icon(Icons.visibility_off, color: Colors.grey),
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
                  SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordResetScreen()));
        
                          },
                            child: Text("Forget Password?")),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        // Create user
                        await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text);
        
                            Navigator.push(context,
                            MaterialPageRoute(builder: (_) => Dashboard()));
                        // Show success message
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(
                        //     backgroundColor: Colors.brown,
                        //     content: Text("Logged In"),
                        //   ),
                        // );
        
                        clearFields();
                      } catch (error) {
                        print(error.toString());
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
                              "Login",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 22),
                            ))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(fontSize: 18),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(fontSize: 18, color: Colors.brown),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
