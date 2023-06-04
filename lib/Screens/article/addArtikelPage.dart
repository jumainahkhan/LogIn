import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login/Screens/homepage/components/home_page_body.dart'; // import halaman home

class AddArticlePage extends StatefulWidget {
  const AddArticlePage({super.key});

  @override
  State<AddArticlePage> createState() => _AddArticlePageState();
}

class _AddArticlePageState extends State<AddArticlePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _imageUrl = TextEditingController();

  final _storage = FirebaseStorage.instance;
  final _articleCollection = FirebaseFirestore.instance.collection('koleksi');

  // Fungsi untuk menyimpan data ke Firebase Firestore
  Future<void> _saveData() async {
    try {
      if (_formKey.currentState!.validate()) {
        // Menyimpan data judul dan deskripsi dari TextFormField
        String judul = _title.text;
        String deskripsi = _description.text;
        String imageUrl = _imageUrl.text;

        // Membuat document baru dengan data yang diisi
        await _addDataToFirestore(judul, deskripsi, imageUrl);

        // Menampilkan notifikasi sukses menggunakan Get.snackbar
        Get.snackbar('Sukses', 'Data berhasil ditambahkan');
        Get.off(
            HomeScreenBody()); // Navigasi ke HomePage setelah klik tombol Save
      }
    } catch (e) {
      // Menampilkan notifikasi error menggunakan Get.snackbar
      Get.snackbar('Error', 'Terjadi kesalahan saat menambahkan data');
    }
  }

  Future<void> _addDataToFirestore(
      String judul, String deskripsi, String imageUrl) async {
    // Membuat document baru dengan data yang diisi
    await _articleCollection.add({
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'judul': judul,
      'deskripsi': deskripsi,
      'imageUrl': imageUrl,
    });
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
            Icon(Icons.post_add_outlined, size: 40),
            Text('Add Artikel'),
            SizedBox(
              width: 180,
            ),
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
                        icon: Icon(
                          Icons.title,
                          color: Colors.brown,
                        ),
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
                      maxLength:
                          1000, // mengubah batas maksimal kata menjadi 1000
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      controller: _description,
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.description_outlined,
                          color: Colors.green,
                        ),
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
                    TextFormField(
                      controller: _imageUrl,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.image,
                          color: Colors.green,
                        ),
                        labelText: 'Masukkan URL gambar terkait artikel',
                        errorStyle: TextStyle(color: Colors.grey),
                        suffixIcon: _imageUrl.text.isNotEmpty
                            ? Image.network(
                                _imageUrl.text,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Mohon Masukkan URL gambar terkait artikel';
                        }
                        return null;
                      },
                      onSaved: (value) {},
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
