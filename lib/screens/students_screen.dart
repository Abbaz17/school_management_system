import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:school_app/widgets/card_btn.dart';

import 'screens.dart';
import 'student_registration.dart';

class StudentsScreen extends StatelessWidget {
  const StudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Students"),
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
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>StudentRegistration()));
                } ,
                backgroundColor: Colors.green,
                title: "Register Student",
                iconData: Icons.app_registration,
                )
                ,
            ),
            Container(
              width: 200,
              height: 200,
              child: CardBtn(
                onPressed: () {
                   Navigator.push(context, MaterialPageRoute(builder: (_)=>StudentListScreen()));
                } ,
                backgroundColor: Colors.green,
                title: "All students",
                iconData: Icons.read_more_sharp,
                ),
            ),
            
          ],
        ));
  }
}
