import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Dashboard",style: TextStyle(
          fontSize: 34 ,
          fontWeight: FontWeight.w800
        ),),
      ),
    );
  }
}