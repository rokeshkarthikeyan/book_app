// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ffi';

import 'package:book_app/model/book.dart';
import 'package:book_app/services/api.dart';
import 'package:book_app/viewmodel/viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookVM>.value(
      value: BookVM(),
      child: MaterialApp(
        title: 'Booking app',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController? nameController;
  TextEditingController? authorController;
  TextEditingController? priceController;
  TextEditingController? idController;

  @override
  void initState() {
    Provider.of<BookVM>(context, listen: false).fetchBookList();
    nameController = TextEditingController();
    authorController = TextEditingController();
    priceController = TextEditingController();
    idController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BookVM bookVM = Provider.of<BookVM>(context, listen: true);

    return Scaffold(
        appBar: AppBar(
          title: Text('Book Store App'),
        ),
        body: Builder(builder: (BuildContext context) {
          if (bookVM.loadingState == ConnectionState.waiting) {
            return Center(
              child: SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              ),
            );
          }
          return Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: bookVM.books.map<Widget>((book) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                          tileColor: Colors.amber,
                          title: Text(bookVM.getbookauthor(book)),
                          subtitle: Text(bookVM.getbookname(book)),
                          trailing: Text(bookVM.getbookprice(book).toString())),
                    );
                  }).toList() ??
                  []);
        }),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Colors.green,
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    height: 700,
                    child: Column(
                      children: [
                        Text('Enter book name'),
                        Center(
                          child: SizedBox(
                            width: 150,
                            child: TextField(
                              controller: nameController,
                            ),
                          ),
                        ),
                        Text('Enter author name'),
                        Center(
                          child: SizedBox(
                            width: 150,
                            child: TextField(
                              controller: authorController,
                            ),
                          ),
                        ),
                        Text('Enter book id'),
                        Center(
                          child: SizedBox(
                            width: 150,
                            child: TextField(
                              controller: idController,
                            ),
                          ),
                        ),
                        Text('Enter book price'),
                        Center(
                          child: SizedBox(
                            width: 150,
                            child: TextField(
                              controller: priceController,
                            ),
                          ),
                        ),
                        Center(
                          child: ElevatedButton(
                              onPressed: () {
                                print(idController?.text);
                                Api.putBookData({
                                  "name": nameController?.text,
                                  "id": int.parse(idController?.text ?? '0'),
                                  "author": authorController?.text,
                                  "price": double.parse(priceController?.text ?? '0.0')
                                });
                              },
                              child: Text('submit')),
                        )
                      ],
                    ),
                  );
                },
              );
            }));
  }
}
