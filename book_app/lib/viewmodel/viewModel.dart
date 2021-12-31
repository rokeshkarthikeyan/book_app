import 'package:book_app/model/book.dart';
import 'package:book_app/services/api.dart';
import 'package:flutter/cupertino.dart';

class BookVM extends ChangeNotifier {
  ConnectionState loadingState = ConnectionState.waiting;
  List<Book?> _books = [];
  void fetchBookList() async {
    try {
      _books = (await Api.getApiData())!;
      loadingState = ConnectionState.done;
      notifyListeners();
    } catch (e) {
      throw 'failed fetch';
    }
  }

  get books => _books;
  int getbookid(book) => book.id;
  String getbookauthor(book) => book.author;
  String getbookname(book) => book.name;
  double getbookprice(book) => book.price;
}
