import 'package:flutter/material.dart';
import 'package:ers/provider/custom_provider.dart';
import 'package:ers/screens/home/home_page.dart';
import 'package:ers/screens/map_page.dart';
import 'package:ers/screens/news/news_page.dart';
import 'package:ers/screens/report_page.dart';
import 'package:ers/screens/safety_page.dart';
import 'package:ers/utils/color_utils.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BottomNavProvider>(context);
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: provider.index,
      selectedItemColor: ColorUtils.primaryColor,
      unselectedItemColor: Colors.black,
      showUnselectedLabels: true,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/home.png',
            color:
                provider.index == 0 ? ColorUtils.primaryColor : Colors.black54,
            height: 28.0,
            width: 28.0,
          ),
          title: Text(
            "Home",
          ),
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/safety.png',
            color:
                provider.index == 1 ? ColorUtils.primaryColor : Colors.black54,
            height: 28.0,
            width: 28.0,
          ),
          title: Text(
            "Safety",
          ),
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/radio.png',
            color:
                provider.index == 2 ? ColorUtils.primaryColor : Colors.black54,
            height: 28.0,
            width: 28.0,
          ),
          title: Text(
            "News",
          ),
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/report.png',
            color:
                provider.index == 3 ? ColorUtils.primaryColor : Colors.black54,
            height: 28.0,
            width: 28.0,
          ),
          title: Text(
            "Report",
          ),
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/address.png',
            color:
                provider.index == 4 ? ColorUtils.primaryColor : Colors.black54,
            height: 28.0,
            width: 28.0,
          ),
          title: Text(
            "Map",
          ),
        )
      ],
      onTap: (index) {
        provider.setIndex = index;
        navigateToPage(context: context, index: index);
      },
    );
  }
}

void navigateToPage({BuildContext context, int index}) {
  Widget page = HomePage();
  switch (index) {
    case 0:
      page = HomePage();
      break;
    case 1:
      page = SafetyPage();
      break;
    case 2:
      page = NewsPage();
      break;
    case 3:
      page = ReportPage();
      break;
    case 4:
      page = MapPage();
  }
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}
