import 'package:ers/controller/corona_data.dart';
import 'package:flutter/material.dart';
import 'package:ers/components/error_widget.dart';
import 'package:ers/model/report_model.dart';
import 'package:ers/screens/home/components/tag.dart';
import 'package:ers/utils/color_utils.dart';
import 'package:provider/provider.dart';

class NigerianTag extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Report>(
      stream: Stream.value(Provider.of<StatesProvider>(context).countryReport),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return SizedBox(
            width: double.maxFinite,
            height: 120.0,
            child: CustomErrorWidget(
              onPressed: () {},
            ),
          );
        } else if (snapshot.hasData) {
          final data = snapshot.data;
          return TagBar(
            title: "Nigeria",
            children: [
              TagChild(
                label: "Total Cases",
                number: data.confirmed,
                textColor: Color(0xFF202125),
              ),
              TagChild(
                label: "Recovered",
                number: data.discharged,
                textColor: Color(0xFF28A745),
              ),
              TagChild(
                label: "Death",
                number: data.death,
                textColor: Color(0xFFDC3545),
              )
            ],
          );
        }
        return SizedBox(
          width: double.maxFinite,
          height: 120.0,
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(ColorUtils.primaryColor),
            ),
          ),
        );
      },
    );
  }
}
