import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login/Screens/account/akunPage.dart';
import 'package:login/Screens/homepage/components/home_page_body.dart';
import 'package:login/Screens/article/artikelPage.dart';
import 'package:provider/provider.dart';
import 'package:login/models/artikelProvider.dart';

import 'addArtikelPage.dart';
import 'detailArtikelPage.dart';

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
  final TextEditingController _imageUrl = TextEditingController();

  Future<String> _addArticle(title, description, imageUrl) {
    return Future.delayed(const Duration(milliseconds: 2250)).then((_) async {
      try {
        String comments = '';
        await Provider.of<artikel>(context, listen: false).addArticle(
          imageUrl,
          title,
          description,
          comments,
        );
      } catch (e) {
        return "An Errorerror occurred: ${e.toString()}";
      }
      return 'Add Article Success';
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
                      controller: _imageUrl,
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.image,
                          color: Colors.green,
                        ),
                        labelText: 'Masukkan image terkait artikel',
                        errorStyle: TextStyle(color: Colors.grey),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Mohon Masukkan image terkait artikel ';
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
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            _addArticle(
                              _title.text,
                              _description.text,
                              _imageUrl.text,
                            ).then((response) {
                              if (response == 'Add Article Success') {
                                return Navigator.pop(context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(response),
                                  ),
                                );
                              }
                            });
                          }
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
