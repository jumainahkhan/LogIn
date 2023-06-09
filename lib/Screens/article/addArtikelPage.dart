import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login/Screens/homepage/components/home_page_body.dart';

class AddArticlePage extends StatefulWidget {
  const AddArticlePage({Key? key}) : super(key: key);

  @override
  State<AddArticlePage> createState() => _AddArticlePageState();
}

class _AddArticlePageState extends State<AddArticlePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();

  File? _imageFile;
  final _storage = FirebaseStorage.instance;
  final _articleCollection = FirebaseFirestore.instance.collection('koleksi');

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  Future<String> _uploadImageToFirebase() async {
    if (_imageFile == null) {
      throw Exception('No file selected');
    }

    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final ref = _storage.ref().child('images/$fileName');
    await ref.putFile(_imageFile!);

    return await ref.getDownloadURL();
  }

  Future<void> _saveData() async {
    try {
      if (_formKey.currentState!.validate()) {
        String judul = _title.text;
        String deskripsi = _description.text;

        String imageUrl = await _uploadImageToFirebase();

        await _articleCollection.add({
          'uid': FirebaseAuth.instance.currentUser!.uid,
          'judul': judul,
          'deskripsi': deskripsi,
          'imageUrl': imageUrl,
        });

        Get.snackbar('Sukses', 'Data berhasil ditambahkan');
        Get.off(HomeScreenBody());
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan saat menambahkan data');
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
              bottomRight: Radius.circular(12),
            ),
            gradient: LinearGradient(
              colors: [Colors.green, Colors.greenAccent],
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.post_add_outlined, size: 40),
            Text('Add Artikel'),
            SizedBox(width: 180),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _title,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.title, color: Colors.brown),
                        labelText: 'Masukkan Judul Artikel',
                        errorStyle: TextStyle(color: Colors.grey),
                      ),
                      maxLength: 25,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'mohon masukkan judul';
                        }
                        return null;
                      },
                      onSaved: (value) {},
                    ),
                    TextFormField(
                      maxLength: 1000,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      controller: _description,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.description_outlined,
                            color: Colors.green),
                        labelText: 'Masukkan deskripsi artikel tersebut',
                        errorStyle: TextStyle(color: Colors.grey),
                      ),
                      autofocus: false,
                      maxLines: 10,
                      keyboardType: TextInputType.multiline,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'mohon masukkan deskripsi';
                        }
                        return null;
                      },
                      onSaved: (value) {},
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: _imageFile != null
                            ? Image.file(_imageFile!, fit: BoxFit.cover)
                            : Icon(Icons.add_a_photo, color: Colors.grey),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(45, 8, 15, 8),
                      child: ElevatedButton(
                        autofocus: true,
                        onPressed: () {
                          _saveData();
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.green),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        ),
                        child: const Text('Save',
                            style: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
