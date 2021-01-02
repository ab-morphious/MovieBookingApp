import 'package:flutter/material.dart';

class IconTextHorizontal extends StatelessWidget {
  IconTextHorizontal({this.icon, this.text});
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return 
          Container(
            child: Row(
              children: [Icon(icon), SizedBox(width: 10.0), Text(text)],
            ),
          );
  }
}
