import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ers/utils/global_data_utils.dart';

class Custom {
  static AppBar customAppBar({BuildContext context}) {
    return AppBar(
      title: Text(
        GlobalDataUtils.APP_TITLE,
        style: GoogleFonts.abel(),
      ),
    );
  }
}
