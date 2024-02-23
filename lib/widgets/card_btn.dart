import 'package:flutter/material.dart';

class CardBtn extends StatelessWidget {
  final IconData iconData;
  final String title;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;
  final VoidCallback onPressed;

  const CardBtn({
    Key? key,
    this.iconData = Icons.arrow_forward,
    this.title = "Button",
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.iconColor = Colors.black,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9 ,horizontal: 5),
      child: Card(
        color: backgroundColor,
        elevation: 9.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13.0),
        ),
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconData,
                  size: 32.0,
                  color: iconColor,
                ),
                const SizedBox(height: 8.0),
                Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
