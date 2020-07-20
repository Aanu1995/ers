import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ers/components/company_name.dart';
import 'package:ers/components/empty_space.dart';

class DetailPage extends StatelessWidget {
  final String content;
  final String title;
  const DetailPage({this.title, this.content});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Safety Measure",
          style: GoogleFonts.abel(),
        ),
      ),
      body: Container(
        margin:
            EdgeInsets.only(left: 16.0, right: 16.0, top: 30.0, bottom: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              EmptySpace(multiple: 2.0),
              Text(
                content,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 16.0,
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: CompanyName(),
    );
  }
}
