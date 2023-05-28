import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  File? _imageFile;
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _fetchData();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
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
        imageUrl = data['imageUrl'];
      });
    }
  }

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _uploadData() async {
    String title = _titleController.text;
    String description = _descriptionController.text;

    if (title.isNotEmpty && description.isNotEmpty && _imageFile != null) {
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');

      UploadTask uploadTask = storageReference.putFile(_imageFile!);
      TaskSnapshot storageTaskSnapshot = await uploadTask;
      String imageUrl = await storageTaskSnapshot.ref.getDownloadURL();

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
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print(imageUrl);
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Artikel'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Judul',
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Deskripsi',
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Pilih Gambar'),
              ),
              SizedBox(height: 16.0),
              imageUrl != null
                  ? Image.network(imageUrl!)
                  : Container(), // Menampilkan gambar yang dipilih
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _uploadData,
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
