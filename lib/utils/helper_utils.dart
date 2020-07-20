import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:path_provider/path_provider.dart';

class HelperUtils {
  static String createRandomString([int length = 64]) {
    final Random _random = Random.secure();
    var values = List<int>.generate(length, (i) => _random.nextInt(256));
    return base64Url.encode(values);
  }

  // To get the path to the directory
  static Future<String> get _localPath async {
    Directory directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

// gets country file
  static Future<File> get _getCountryFile async {
    final path = await _localPath;
    return File(path + "country.json");
  }

  static Future<dynamic> readCountryFile() async {
    try {
      File file = await _getCountryFile;
      return json.decode(file.readAsStringSync());
    } catch (e) {
      print(e);
    }
  }

  static void writeCountryFile(var savedFile) async {
    File file = await _getCountryFile;
    file.writeAsStringSync(savedFile);
  }
}
