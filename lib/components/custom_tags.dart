import 'package:flutter/material.dart';
import 'package:ers/components/empty_space.dart';

class CustomTags extends StatelessWidget {
  final String label;
  final int number;
  final Color backgroundColor;
  final Color textColor;
  const CustomTags(
      {this.number, this.label, this.backgroundColor, this.textColor});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          EmptySpace(multiple: 0.8),
          SizedBox(
            height: 32.0,
            width: 100.0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: backgroundColor ?? Colors.amber,
              ),
              child: Center(
                child: Text(
                  '$number',
                  style: TextStyle(
                    fontSize: 17.0,
                    color: textColor ?? Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
