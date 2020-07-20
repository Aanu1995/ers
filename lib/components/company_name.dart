import 'package:flutter/material.dart';
import 'package:ers/utils/color_utils.dart';

class CompanyName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "TREP LABS",
      style: Theme.of(context).primaryTextTheme.caption.copyWith(
            color: ColorUtils.primaryColor,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}
