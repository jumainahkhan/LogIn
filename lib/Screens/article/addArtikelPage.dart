import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login/Screens/article/artikelPage.dart';
import 'package:provider/provider.dart';
import 'package:login/models/artikelProvider.dart';

class AddArticlePage extends StatefulWidget {
  const AddArticlePage({super.key});

  @override
  State<AddArticlePage> createState() => _AddArticlePageState();
}

class _AddArticlePageState extends State<AddArticlePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _comments = TextEditingController();
  String? _imageUrl;
  File? _imageFile;
  final _storage = FirebaseStorage.instance;
  final _articleCollection = FirebaseFirestore.instance.collection('koleksi');
  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().getImage(source: source);
    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  // Fungsi untuk menyimpan data ke Firebase Firestore
  Future<void> _saveData() async {
    try {
      if (_formKey.currentState!.validate()) {
        // Menyimpan data judul dan deskripsi dari TextFormField
        String judul = _title.text;
        String deskripsi = _description.text;

        // Mengecek apakah telah dipilih gambar
        if (_imageFile != null) {
          // Menyimpan gambar ke Firebase Storage
          String imageUrl = await _uploadImageToStorage(_imageFile!);

          // Membuat document baru dengan data yang diisi
          await _addDataToFirestore(judul, deskripsi, imageUrl);

          // Menampilkan notifikasi sukses menggunakan Get.snackbar
          Get.snackbar('Sukses', 'Data berhasil ditambahkan');
          Get.off(ArtikelPage());
        } else {
          // Menampilkan notifikasi error jika gambar tidak dipilih
          Get.snackbar('Error', 'Mohon pilih gambar terlebih dahulu');
        }
      }
    } catch (e) {
      // Menampilkan notifikasi error menggunakan Get.snackbar
      Get.snackbar('Error', 'Terjadi kesalahan saat menambahkan data');
    }
  }

  Future<String> _uploadImageToStorage(File imageFile) async {
    // Mendapatkan referensi pada Firebase Storage
    Reference storageRef = _storage.ref().child('images/${DateTime.now()}.png');

    // Mengunggah gambar ke Firebase Storage
    TaskSnapshot snapshot = await storageRef.putFile(imageFile);

    // Mendapatkan URL gambar yang diunggah
    String imageUrl = await snapshot.ref.getDownloadURL();

    return imageUrl;
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
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // memberi spasi antar widget
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
                          errorStyle: TextStyle(color: Colors.grey)),
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
                      maxLength: 200,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      controller: _description,
                      decoration: const InputDecoration(
                          icon: Icon(
                            Icons.description_outlined,
                            color: Colors.green,
                          ),
                          labelText: 'Masukkan deskripsi artikel tersebut',
                          errorStyle: TextStyle(color: Colors.grey)),
                      autofocus: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'mohon masukkan deskripsi';
                        }
                        return null;
                      },
                      onSaved: (value) {},
                    ),
                    TextFormField(
                      controller: _imageUrl != null
                          ? TextEditingController(text: _imageUrl)
                          : null,
                      readOnly: true,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.image,
                          color: Colors.green,
                        ),
                        labelText: 'Masukkan image terkait artikel',
                        errorStyle: TextStyle(color: Colors.grey),
                        suffixIcon: _imageFile != null
                            ? Image.file(
                                _imageFile!,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Pilih Gambar'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: Icon(Icons.photo_library),
                                  title: const Text('Galeri'),
                                  onTap: () {
                                    Navigator.pop(context);
                                    _pickImage(ImageSource.gallery);
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.camera_alt),
                                  title: const Text('Kamera'),
                                  onTap: () {
                                    Navigator.pop(context);
                                    _pickImage(ImageSource.camera);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Mohon Masukkan image terkait artikel';
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
