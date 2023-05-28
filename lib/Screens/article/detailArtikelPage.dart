import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailArtikelPage extends StatefulWidget {
  final String id;

  const DetailArtikelPage({Key? key, required this.id}) : super(key: key);
  @override
  State<DetailArtikelPage> createState() => _DetailArtikelPageState();
}

class _DetailArtikelPageState extends State<DetailArtikelPage> {
  DocumentSnapshot? _articleSnapshot;

  bool isLiked = false; // status like
  bool isSaved = false; // status save

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
        print('Artikel tidak ditemukan');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _articleSnapshot?['judul'] ?? '',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(
              isSaved ? Icons.bookmark : Icons.bookmark_border,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                isSaved = !isSaved;
              });
            },
          ),
          IconButton(
            icon: Icon(
              Icons.edit,
              color: Colors.black,
            ),
            onPressed: () {
              // navigasi ke halaman edit
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  _articleSnapshot?['imageUrl'] ??
                      'https://firebasestorage.googleapis.com/v0/b/health-5f252.appspot.com/o/images%2F2023-05-26%2022%3A44%3A10.930239.png?alt=media&token=9c55f402-c174-498b-bef1-35b364f6f55c',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Deskripsi',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      setState(() {
                        isLiked = !isLiked;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                _articleSnapshot?['deskripsi'] ?? '',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              // Tempat untuk fitur komentar
            ],
          ),
        ),
      ),
    );
  }
}
