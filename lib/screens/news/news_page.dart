import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ers/components/export_components.dart';
import 'package:ers/provider/custom_provider.dart';
import 'package:ers/screens/home/home_page.dart';
import 'package:ers/screens/news/detail_news_page.dart';
import 'package:provider/provider.dart';

class NewsPage extends StatelessWidget {
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
        appBar: AppBar(
          title: Text(
            "News",
            style: GoogleFonts.abel(),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                flex: 8,
                child: Container(
                  height: double.maxFinite,
                  child: NewsCard(
                    text: "World Statistics",
                    color: Colors.blue,
                    image: "assets/who.png",
                    page: DetailNewsPage(
                      title: "World Statistics",
                      url: "https://trackcorona.live",
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Expanded(
                flex: 8,
                child: NewsCard(
                  text: "Nigeria Statistics",
                  color: Colors.green,
                  image: "assets/ncdc.png",
                  page: DetailNewsPage(
                    title: "Nigeria Statistics",
                    url: "https://covid19.ncdc.gov.ng",
                  ),
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Expanded(
                flex: 8,
                child: NewsCard(
                  text: "Edo State News",
                  color: Colors.grey,
                  image: "assets/edo.png",
                  page: DetailNewsPage(
                    title: "Edo State News",
                    url: "https://www.today.ng/topic/edo-state",
                  ),
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

class NewsCard extends StatelessWidget {
  final Color color;
  final image;
  final String text;
  final Widget page;
  NewsCard({this.color, this.image, this.text, this.page});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => page)),
      child: Card(
        color: color,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        margin: EdgeInsets.all(0.0),
        child: Container(
          width: double.maxFinite,
          margin: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                text,
                style: TextStyle(
                  fontSize: size.width * 0.05,
                  color: Colors.white,
                ),
              ),
              EmptySpace(multiple: 2.0),
              Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  image,
                  height: size.height * 0.09,
                  width: size.width * 0.5,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
