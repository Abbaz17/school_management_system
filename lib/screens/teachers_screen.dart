import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:school_app/screens/teacher_registration.dart';
import 'package:school_app/widgets/card_btn.dart';

import 'screens.dart';
import 'student_registration.dart';

class TeacherScreen extends StatelessWidget {
  const TeacherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown.shade400,
          title: Text("Teachers"),
          centerTitle: true,
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 200,
              height: 200,
              child: CardBtn(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>TeacherRegistration()));
                } ,
                backgroundColor: Colors.brown.shade400,
                title: "Register Teacher",
                iconData: Icons.app_registration,
                )
                ,
            ),
            Container(
              width: 200,
              height: 200,
              child: CardBtn(
                onPressed: () {
                   Navigator.push(context, MaterialPageRoute(builder: (_)=>TeacherList()));
                } ,
                backgroundColor: Colors.brown.shade400,
                title: "All Teachers",
                iconData: Icons.read_more_sharp,
                ),
            ),
            
          ],
        ));
  }
}
