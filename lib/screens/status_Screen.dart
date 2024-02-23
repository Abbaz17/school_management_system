import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:school_app/widgets/card_btn.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/widgets.dart';
import 'screens.dart';
import 'student_registration.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown.shade400,
        title: Text("Status"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SatusCard(iconData: FontAwesomeIcons.school,
              title: "Students ",
              ),
              SatusCard(
                iconData: FontAwesomeIcons.pen ,
                 title: "Teachers ",
                //  size: 20,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SatusCard(
                iconData: FontAwesomeIcons.home,
              title: "Classes ",
              ),
              SatusCard(
                iconData: FontAwesomeIcons.readme,
                 title: "Foculties ",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
