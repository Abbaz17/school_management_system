import 'package:flutter/material.dart';

class SatusCard extends StatelessWidget {
  final IconData iconData;
  final String? title;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;
  final double size;
  final String num;
  const SatusCard(
      {super.key,
      this.iconData = Icons.arrow_forward,
      this.title = "Button",
      this.backgroundColor = Colors.brown,
      this.textColor = Colors.black,
      this.iconColor = Colors.black,
      this.size = 30,
      this.num = "120+"});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 5),
      child: Container(
        
        width: 200,
        height: 200,
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                iconData,
                size: size,
              ),
              Text(
                "$title",
                style: TextStyle(
                  fontSize: 20 ,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("$num" , style: TextStyle(
                  fontSize: 20 ,
                  fontWeight: FontWeight.bold,
                  color: Colors.white60
                ),)
            ],
          ),
          color: backgroundColor,
          elevation: 9.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13.0),
          ),
        ),
      ),
    );
  }
}
