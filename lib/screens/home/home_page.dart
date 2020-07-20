import 'package:flutter/material.dart';
import 'package:ers/components/custom_app_bar.dart';
import 'package:ers/components/export_components.dart';
import 'package:ers/provider/custom_provider.dart';
import 'package:ers/screens/home/components/nigeria_tag.dart';
import 'package:ers/screens/map_page.dart';
import 'package:ers/screens/news/news_page.dart';
import 'package:ers/screens/report_page.dart';
import 'package:ers/screens/safety_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Custom.customAppBar(context: context),
      body: Container(
        margin: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            NigerianTag(),
            EmptySpace(multiple: 3.0),
            SizedBox(
              height: 60.0,
              width: double.maxFinite,
              child: InkWell(
                onTap: () => HelperFunction.launchURL(url: 'tel://08033070005'),
                child: Card(
                  elevation: 10.0,
                  shape: StadiumBorder(),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.phone),
                        SizedBox(width: 16.0),
                        Text(
                          "Emergency",
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            EmptySpace(multiple: 3.0),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                padding: EdgeInsets.only(top: 24.0, bottom: 8.0),
                children: <Widget>[
                  PageCard(
                    index: 1,
                    text: "Safety",
                    page: SafetyPage(),
                    backgroundColor: Color(0xFF4285F4),
                  ),
                  PageCard(
                    index: 2,
                    text: "News",
                    page: NewsPage(),
                    backgroundColor: Color(0xFFF4B400),
                  ),
                  PageCard(
                    index: 3,
                    text: "Report",
                    page: ReportPage(),
                    backgroundColor: Color(0xFFDB4437),
                  ),
                  PageCard(
                    index: 4,
                    text: "Map",
                    page: MapPage(),
                    backgroundColor: Color(0xFF0F9D58),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PageCard extends StatelessWidget {
  final Color backgroundColor;
  final String text;
  final Widget page;
  final Color textColor;
  final int index;
  PageCard(
      {this.backgroundColor, this.text, this.page, this.textColor, this.index});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<BottomNavProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        provider.setIndex = index;
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => page));
      },
      child: Card(
        color: backgroundColor ?? Colors.white,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: EdgeInsets.all(0.0),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: size.width * 0.06,
              color: textColor ?? Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
