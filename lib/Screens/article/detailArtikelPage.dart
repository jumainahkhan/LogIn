import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login/Screens/article/editartikelPage.dart';

import '../homepage/home_page.dart';

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

  Future<void> _delete() async {
    await FirebaseFirestore.instance
        .collection('koleksi')
        .doc(widget.id)
        .delete();
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
            onPressed: () {
              _showDeleteConfirmationDialog();
            },
            icon: Icon(Icons.delete),
            color: Colors.black,
          ),
          IconButton(
            icon: Icon(
              Icons.edit,
              color: Colors.black,
            ),
            onPressed: () {
              // navigasi ke halaman edit
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        EditArtikelPage(documentId: widget.id)),
              );
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

  void _showDeleteConfirmationDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Konfirmasi Hapus'),
            content: Text('Apakah Anda yakin ingin menghapus data ini?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Tutup dialog
                },
                child: Text('Batal'),
              ),
              TextButton(
                onPressed: () {
                  _delete(); // Panggil fungsi untuk menghapus data
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                child: Text(
                  'Hapus',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          );
        });
  }
}
