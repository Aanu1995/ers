import 'package:ers/components/custom_tags.dart';
import 'package:flutter/material.dart';
import 'package:ers/components/empty_space.dart';
import 'package:ers/components/export_components.dart';
import 'package:ers/model/report_model.dart';

class CustomBottomSheets {
  static displayData(BuildContext context, Report report) async {
    showBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 5.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      CustomTags(
                        label: "TOTAL CONFIRMED",
                        number: report.confirmed,
                        backgroundColor: Colors.amber,
                        textColor: Colors.black,
                      ),
                      CustomTags(
                        label: "ACTIVE CASES",
                        number: report.active,
                        backgroundColor: Colors.redAccent,
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                  EmptySpace(multiple: 2.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      CustomTags(
                        label: "TOTAL DISCHARGED",
                        number: report.discharged,
                        backgroundColor: Colors.green,
                      ),
                      CustomTags(
                        label: "TOTAL DEATHS",
                        number: report.death,
                        backgroundColor: Colors.black54,
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                ],
              )),
        );
      },
    );
  }
}
