import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'locale_provider.dart';

class FetchHelper {
  FetchHelper();

  Future<dynamic> getData() async {
    DateTime date = DateTime.now();
    String locale = LocaleProvider().locale?.languageCode ?? 'en';
    int dayOfTheYear = date.difference(DateTime(date.year, 1, 1)).inDays;
    final fullUrl =
        'https://timo-e97a8-default-rtdb.firebaseio.com/quotes/$locale/quote$dayOfTheYear.json';

    try {
      http.Response response = await http.get(Uri.parse(fullUrl));
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        return body;
      } else {
        return 1;
      }
    } on SocketException catch (_) {
      return 0;
    }
  }
}
