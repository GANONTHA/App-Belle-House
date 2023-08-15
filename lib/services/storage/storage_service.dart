import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  final FirebaseStorage storage = FirebaseStorage.instance;

  //upload an image

  Future<void> uploadFile(String filePath, String fileName) async {
    File file = File(filePath);

    try {
      await storage.ref('images/$fileName').putFile(file);
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }
  }
  //list all files in the backet

  Future<ListResult> listFiles() async {
    ListResult results = await storage.ref('images').listAll();

    for (var ref in results.items) {
      print('Found files: $ref');
    }
    return results;
  }
}
