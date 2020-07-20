import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  final String title;
  HeaderText({this.title});
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: double.maxFinite,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: textTheme.title.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
        ),
      ),
    );
  }
}
