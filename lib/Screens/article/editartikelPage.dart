import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login/Screens/homepage/components/home_page_body.dart';
import 'package:login/Screens/homepage/home_page.dart';

class EditArtikelPage extends StatefulWidget {
  final String documentId;

  EditArtikelPage({required this.documentId});

  @override
  _EditArtikelPageState createState() => _EditArtikelPageState();
}

class _EditArtikelPageState extends State<EditArtikelPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageUrlController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _imageUrlController = TextEditingController();
    _fetchData();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _fetchData() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('koleksi')
        .doc(widget.documentId)
        .get();

    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      setState(() {
        _titleController.text = data['judul'];
        _descriptionController.text = data['deskripsi'];
        _imageUrlController.text = data['imageUrl'];
      });
    }
  }

  void _uploadData() async {
    String title = _titleController.text;
    String description = _descriptionController.text;
    String imageUrl = _imageUrlController.text;

    if (title.isNotEmpty && description.isNotEmpty && imageUrl.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('koleksi')
          .doc(widget.documentId)
          .update({
        'judul': title,
        'deskripsi': description,
        'imageUrl': imageUrl,
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreenBody()),
      );
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.edit_outlined, size: 40),
            Text('Edit Artikel'),
            SizedBox(
              width: 180,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.title,
                    color: Colors.brown,
                  ),
                  labelText: 'Masukkan Judul Artikel',
                  errorStyle: TextStyle(color: Colors.grey),
                ),
                maxLength: 25,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.description_outlined,
                    color: Colors.green,
                  ),
                  labelText: 'Masukkan deskripsi artikel',
                  errorStyle: TextStyle(color: Colors.grey),
                ),
                maxLines: 10,
                keyboardType: TextInputType.multiline,
                maxLength: 1000,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.image_outlined,
                    color: Colors.green,
                  ),
                  labelText: 'Masukkan URL Gambar',
                  errorStyle: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _uploadData,
                child: Text('Simpan'),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
