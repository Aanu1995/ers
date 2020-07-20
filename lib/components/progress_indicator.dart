import 'package:flutter/material.dart';
import 'package:ers/utils/color_utils.dart';

class CustomProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(ColorUtils.primaryColor),
      ),
    );
  }
}
