import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailArtikelPage extends StatefulWidget {
  final String id;

  const DetailArtikelPage({super.key, required this.id});
  @override
  State<DetailArtikelPage> createState() => _DetailArtikelPageState();
}

class _DetailArtikelPageState extends State<DetailArtikelPage> {
  DocumentSnapshot? _articleSnapshot;
  @override
  void initState() {
    super.initState();
    // Mengambil data artikel dari Firestore
    _fetchArticle();
  }

  Future<void> _fetchArticle() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('koleksi')
          .doc(widget.id)
          .get();

      if (snapshot.exists) {
        setState(() {
          _articleSnapshot = snapshot;
        });
      } else {
        print('error');
        // Artikel tidak ditemukan
        // Tampilkan pesan atau navigasikan ke halaman lain
      }
    } catch (e) {
      print(e);
      // Error saat mengambil data artikel
      // Tampilkan pesan atau tindakan yang sesuai
    }
  }

  @override
  Widget build(BuildContext context) {
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
            Text(_articleSnapshot?['judul'] ?? ''),
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
                  _articleSnapshot?['imageUrl'] ??
                      'https://firebasestorage.googleapis.com/v0/b/health-5f252.appspot.com/o/images%2F2023-05-26%2022%3A44%3A10.930239.png?alt=media&token=9c55f402-c174-498b-bef1-35b364f6f55c',
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
                    'Deskripsi',
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
                _articleSnapshot?['deskripsi'] ?? '',
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
