import 'package:flutter/material.dart';

class RoundedTimeButton extends StatelessWidget {
  RoundedTimeButton({this.time, this.availability, this.onPressed, this.color});
  final bool availability;
  final String time;
  final Function onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    String availabilityText = availability ? ' (Available)' : ' (Not available)';
    return FlatButton(
              onPressed: onPressed,
              color: color,
              child: Text(time + '$availabilityText'),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.grey[500])),
            );
  }

}