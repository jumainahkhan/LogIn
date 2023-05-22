import 'package:flutter/material.dart';
import 'package:login/Screens/account/akunPage.dart';
import 'package:login/Screens/homepage/components/home_page_body.dart';
import 'package:login/Screens/article/artikelPage.dart';
import 'package:provider/provider.dart';
import 'package:login/models/artikelProvider.dart';

import 'addArtikelPage.dart';
import 'detailArtikelPage.dart';

class DetailArtikelPage extends StatefulWidget {
  final String id;

  const DetailArtikelPage({super.key, required this.id});
  @override
  State<DetailArtikelPage> createState() => _DetailArtikelPageState();
}

class _DetailArtikelPageState extends State<DetailArtikelPage> {
  @override
  Widget build(BuildContext context) {
    final article = Provider.of<artikel>(context).selectById(widget.id);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        flexibleSpace: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12)),
            gradient:
                LinearGradient(colors: [Colors.green, Colors.greenAccent]),
          ),
        ),
        title: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // memberi spasi antar widget
          children: [
            Icon(Icons.library_books_rounded, size: 40),
            Text('Detail Article'),
            SizedBox(
              width: 100,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12.0),
              width: double.infinity,
              height: 250,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                child: Image.network(
                  article.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    article.title,
                    style: const TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: Colors.greenAccent,
              ),
              height: 200,
              width: 450,
              child: Text(
                article.description,
                style: const TextStyle(
                  fontSize: 24,
                ),
                maxLines: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
