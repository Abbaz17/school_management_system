import 'package:flutter/material.dart';
import 'package:school_app/screens/screens.dart';

import '../widgets/widgets.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>StudentsScreen()));
                    },
                  ),
                ),
                Expanded(
                  child: CardBtn(
                    backgroundColor: Colors.orange,
                    textColor: Colors.white,
                    onPressed: () {
                      // Add your onPressed logic here
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
                    textColor: Colors.white,
                    onPressed: () {
                      // Add your onPressed logic here
                    },
                  ),
                ),
                Expanded(
                  child: CardBtn(
                    backgroundColor: Colors.purple,
                    textColor: Colors.white,
                    onPressed: () {
                      // Add your onPressed logic here
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
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    onPressed: () {
                      // Add your onPressed logic here
                    },
                  ),
                ),
                Expanded(
                  child: CardBtn(
                    backgroundColor: Colors.teal,
                    textColor: Colors.white,
                    onPressed: () {
                      // Add your onPressed logic here
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

