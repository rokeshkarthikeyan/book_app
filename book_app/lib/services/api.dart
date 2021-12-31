import 'package:book_app/model/book.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  static const String _getBookAPI =
      '''http://books-dk-1802.herokuapp.com/books''';

  static get value => null;
  static Future<List<Book>?> getApiData() async {
    http.Response response = await http.get(Uri.parse(_getBookAPI));
    print(response.body);
    if (response.statusCode == 200) {
      await Future.delayed(const Duration(seconds: 3));
      List<Map> list = (jsonDecode(response.body) as List).cast<Map>();
      List<Book> users = list.map<Book>((Map map) {
        return Book.fromJson(map.cast<String, dynamic>());
      }).toList();
      return users;
    } else {
      print('Fetch Failed');
      return null;
    }
  }

  static Future<List<Book>?> putBookData(Map bosy) async {
    http.Response response = await http. post(
        Uri.parse('''http://books-dk-1802.herokuapp.com/books'''),
        body: bosy);
    print(response.body);
  }
}
