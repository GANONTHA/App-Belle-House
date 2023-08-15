import 'package:bellehouse/services/storage/storage_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(LineAwesomeIcons.angle_left),
          color: const Color(0xFF6C63FF),
        ),
        title: const Text(
          "AJOUTER UNE PROPRIETE",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 5.0, right: 5.0),
        child: Column(
          children: [
            Container(
              height: 90.0,
              decoration: const BoxDecoration(color: Color(0xFFD9D9D9)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        const Text(
                          'IMAGES',
                          style: TextStyle(
                              color: Color(0xFF6C63FF),
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Material(
                          color: Colors.white10,
                          child: Center(
                            child: Ink(
                              height: 22,
                              width: 22,
                              decoration: const ShapeDecoration(
                                color: Colors.black,
                                shape: CircleBorder(),
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.question_mark,
                                  size: 12,
                                ),
                                color: Colors.white,
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'Ajouter des images de votre propriete',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 17.0),
            const Text('Ajouter au moins 3 images au plus 6',
                style: TextStyle(fontSize: 15.0)),
            Container(
              height: 30.0,
              width: 200,
              decoration: const BoxDecoration(
                color: Color(0xFF6C63FF),
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
              child: TextButton(
                onPressed: () async {
                  final result = await FilePicker.platform.pickFiles(
                    allowMultiple: false,
                    type: FileType.custom,
                    allowedExtensions: ['png', 'jpg', 'jfif'],
                  );

                  if (result == null) {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Aucune image selectionee')));
                    return;
                  }
                  final path = result.files.single.path;
                  final fileName = result.files.single.name;

                  storage.uploadFile(path!, fileName);
                },
                child: const Text(
                  'Choisir des images',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            FutureBuilder(
                future: storage.listFiles(),
                builder:
                    (BuildContext context, AsyncSnapshot<ListResult> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return Container(
                      height: 200,
                      decoration: const BoxDecoration(color: Colors.white),
                      child: ListView.builder(
                          itemCount: 3,
                          itemBuilder: (BuildContext context, index) {
                            return ElevatedButton(
                              onPressed: () {},
                              child: Text(snapshot.data!.items[index].name),
                            );
                          }),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      !snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  return Container();
                })
          ],
        ),
      ),
    );
  }
}
