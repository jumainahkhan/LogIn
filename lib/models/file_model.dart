import 'dart:typed_data';

class FileModel {
  String filename;
  Uint8List fileBytes;

  FileModel({required this.filename, required this.fileBytes});
}
