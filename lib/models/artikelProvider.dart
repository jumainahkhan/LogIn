import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'article.dart';

class artikel with ChangeNotifier {
  final List<Article> _allarticle = [];
  List<Article> get allArticle => _allarticle;

  String baseurl = "https://kesehatan-f98b1-default-rtdb.firebaseio.com/";

  Article selectById(String id) {
    return _allarticle.firstWhere((element) => element.id == id,
        orElse: () => null as Article);
  }

  Future<void> addArticle(image, title, description, comment) async {
    var url = Uri.parse("$baseurl/article.json");
    try {
      await http
          .post(
        url,
        body: json.encode(
          {
            "image": image,
            "title": title,
            "description": description,
            "comment": comment,
          },
        ),
      )
          .then((response) {
        if (response.statusCode == 200) {
          var id = json.decode(response.body);
          _allarticle.add(Article(
              id: id["name"],
              image: image,
              title: title,
              description: description,
              comments: comment));

          notifyListeners();
        } else {
          throw Exception('Failed to add data');
        }
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getAllArticle() async {
    var url = Uri.parse("$baseurl/article.json");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var article = json.decode(response.body) as Map<String, dynamic>;
      _allarticle.clear();
      article.forEach((key, value) {
        _allarticle.add(Article(
            id: key,
            title: value["title"],
            description: value["description"],
            image: value["image"],
            comments: value["comment"]));
      });
      notifyListeners();
    }
  }
}
