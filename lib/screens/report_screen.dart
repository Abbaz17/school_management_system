import 'package:flutter/material.dart';
import 'package:school_app/screens/teacher_registration.dart';
import 'package:school_app/widgets/card_btn.dart';
import 'screens.dart';
import 'student_registration.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text("Reports"),
        centerTitle: true,
      ),
      body: 
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 200,
                height: 200,
                child: CardBtn(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => StudentReportScreen()));
                  },
                  backgroundColor: Colors.brown.shade400,
                  title: "Students Report",
                  iconData: Icons.app_registration,
                ),
              ),
              Container(
                width: 200,
                height: 200,
                child: CardBtn(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => TeacherReportScreen()));
                  },
                  backgroundColor: Colors.brown.shade400,
                  title: "Teachers Reports",
                  iconData: Icons.read_more_sharp,
                ),
              ),
            ],
          ),
        
    );
  }
}
