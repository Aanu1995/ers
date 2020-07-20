import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  final void Function() onPressed;
  CustomErrorWidget({this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          "Please check your internet connection",
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        FlatButton(
          onPressed: onPressed,
          child: Text("Try Again"),
        )
      ],
    );
  }
}
