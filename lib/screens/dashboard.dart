import 'package:flutter/material.dart';
import 'package:school_app/screens/parent_list.dart';
import 'package:school_app/screens/screens.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/widgets.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text("Dashboard"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: CardBtn(
                    iconData: Icons.book,
                    title: "Students!",
                    backgroundColor: Colors.blue,
                    textColor: Colors.white,
                    iconColor: Colors.green,
                    onPressed: () {
                      // Add your onPressed logic here
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => StudentsScreen()));
                    },
                  ),
                ),
                Expanded(
                  child: CardBtn(
                    title: "Teachers!",
                    iconData: Icons.text_fields,
                    backgroundColor: Colors.orange,
                    textColor: Colors.white,
                    onPressed: () {
                      // Add your onPressed logic here
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => TeacherScreen()));
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: CardBtn(
                    backgroundColor: Colors.green,
                    title: "Reports",
                    iconData: Icons.report_gmailerrorred_outlined,
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.push(context ,MaterialPageRoute(builder: (_)=>ReportScreen()));
                    },
                  ),
                ),
                Expanded(
                  child: CardBtn(
                    title: "classes",
                    iconData: Icons.school,
                    backgroundColor: Colors.purple,
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => ClassesScreen()));
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: CardBtn(
                    title: "Parents",
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    iconData: FontAwesomeIcons.peopleRobbery,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => ParentsScreen()));
                    },
                  ),
                ),
                Expanded(
                  child: CardBtn(
                    title: "Status Screen",
                    iconData: Icons.inbox,
                    backgroundColor: Colors.teal,
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>StatusScreen())) ;
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed:() => Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginScreenF())),
              icon: Icon(Icons.backspace),
              label: Text("Logout"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
              ),
            ),
          )
        ],
      ),
    );
  }
}
