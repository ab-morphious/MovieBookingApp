import 'package:flutter/material.dart';

class SeatRowLabel extends StatelessWidget {
  SeatRowLabel({this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        child: Center(child: Text(label)),
      ),
    );
  }
}
