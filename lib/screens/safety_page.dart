import 'package:flutter/material.dart';
import 'package:ers/components/bottom_navigation_bar.dart';
import 'package:ers/components/custom_app_bar.dart';
import 'package:ers/components/empty_space.dart';
import 'package:ers/components/custom_page_route.dart';
import 'package:ers/components/header_text.dart';
import 'package:ers/provider/custom_provider.dart';
import 'package:ers/screens/home/home_page.dart';
import 'package:ers/utils/color_utils.dart';
import 'package:ers/model/prevention_model.dart';
import 'package:ers/screens/detail_page.dart';
import 'package:provider/provider.dart';

class SafetyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BottomNavProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        provider.setIndex = 0;
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        return false;
      },
      child: Scaffold(
        appBar: Custom.customAppBar(context: context),
        body: Container(
          margin: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              HeaderText(
                title: "Preventive measures",
              ),
              EmptySpace(multiple: 3.0),
              Expanded(
                child: ListView.builder(
                  itemCount: PreventionModel.prevention.length,
                  itemBuilder: (context, index) {
                    final list = PreventionModel.prevention;
                    return CustomCard(data: list[index]);
                  },
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final PreventionModel data;
  CustomCard({this.data});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          CustomPageRoute(
            builder: (context) => DetailPage(
              title: data.title,
              content: data.content,
            ),
          ),
        );
      },
      child: Card(
        elevation: 10,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  data.title,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 16.0,
                    height: 1.3,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              EmptySpace(horizontal: true, multiple: 1.5),
              Icon(
                Icons.navigate_next,
                color: ColorUtils.primaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
