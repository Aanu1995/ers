import 'package:ers/controller/corona_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ers/provider/custom_provider.dart';
import 'package:ers/screens/splash_page.dart';
import 'package:ers/utils/color_utils.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  return runApp(
    MyApp(),
  );
}

init() async {
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive..init(appDocumentDir.path);
}

class MyApp extends StatelessWidget {
  final StatesProvider _statesProvider = StatesProvider();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.black),
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BottomNavProvider(),
        ),
        ChangeNotifierProvider<StatesProvider>(
          create: (_) => _statesProvider,
        ),
      ],
      child: MaterialApp(
        title: 'ERS',
        theme: ThemeData(
          primaryColor: ColorUtils.primaryColor,
          accentColor: ColorUtils.primaryColor,
        ),
        debugShowCheckedModeBanner: false,
        home: SplashPage(),
      ),
    );
  }
}
