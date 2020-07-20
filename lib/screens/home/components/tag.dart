import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ers/components/export_components.dart';

class TagBar extends StatelessWidget {
  final String title;
  final List<Widget> children;
  TagBar({this.title, this.children});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 18.0,
              color: Color(0xFF5A82FC),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        EmptySpace(multiple: 1.5),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: children,
          ),
        ),
      ],
    );
  }
}

class TagChild extends StatelessWidget {
  final String label;
  final int number;
  final Color textColor;
  const TagChild({this.label, this.number, this.textColor});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF8F8F91),
          ),
        ),
        EmptySpace(multiple: 0.5),
        Text(
          NumberFormat().format(number),
          style: TextStyle(
            fontSize: 22.0,
            color: textColor ?? Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
