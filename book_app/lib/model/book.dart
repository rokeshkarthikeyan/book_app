import 'package:flutter/material.dart';

class Book {
  Book({
    required this.id,
    required this.name,
    required this.author,
    required this.price,
  });

  final int id;
  final String name;
  final String author;
  final double price;

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        id: json["id"],
        name: json["name"],
        author: json["author"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "author": author,
        "price": price,
      };
}
