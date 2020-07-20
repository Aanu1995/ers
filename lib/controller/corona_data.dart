import 'dart:async';
import 'dart:convert';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:ers/model/report_model.dart';
import 'package:ers/utils/global_data_utils.dart';
import 'package:ers/utils/helper_utils.dart';

class CoronaData {
  Future<Report> getCountryReport() async {
    String url = 'https://www.trackcorona.live/api/countries/ng';
    bool connection = await DataConnectionChecker().hasConnection;
    if (connection) {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        final countryData = result['data'][0];
        HelperUtils.writeCountryFile(json.encode(countryData));
        return Report.fromMap(countryData);
      }
    }
    return Report.fromMap(await HelperUtils.readCountryFile());
  }

  Future<List<Report>> getAllStates() async {
    List<String> states = GlobalDataUtils.states;
    var box = await Hive.openBox('ers');

    final totalStates = states.length;
    List map = [];
    List<Report> reports = [];
    bool connection = await DataConnectionChecker().hasConnection;
    if (!connection) {
      map = await box.get('map');
      map.forEach((value) => reports.add(Report.fromMap(value)));
      print(reports.length);
      return reports;
    }
    if (connection) {
      for (int index = 0; index < totalStates; index++) {
        try {
          final state = states[index];
          String url = 'https://www.trackcorona.live/api/cities/$state';
          http.Response response = await http.get(url);
          if (response.statusCode == 200) {
            var result = json.decode(response.body)['data'];
            if (result.length > 0) {
              final totalResults = result.length;
              for (int i = 0; i < totalResults; i++) {
                if ((result[i]['location']).toLowerCase() ==
                    state.toLowerCase()) {
                  final countryData = result[i];
                  print(countryData);
                  map.add(countryData);
                }
              }
            }
          }
        } catch (e) {}
      }
      box.put('map', map);
      map.forEach((value) => reports.add(Report.fromMap(value)));
    }
    print(reports.length);
    return reports;
  }
}

class StatesProvider with ChangeNotifier {
  final CoronaData _coronaData = CoronaData();
  List<Report> reports;
  Report countryReport;

  StatesProvider() {
    getCountry();
    getStates();
  }

  void getStates() async {
    reports = await _coronaData.getAllStates();
    notifyListeners();
  }

  void getCountry() async {
    countryReport = await _coronaData.getCountryReport();
    notifyListeners();
  }
}
