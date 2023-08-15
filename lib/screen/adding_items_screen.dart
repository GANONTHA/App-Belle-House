import 'package:bellehouse/model/form/upload_image.dart';
import 'package:flutter/material.dart';

class AddItems extends StatefulWidget {
  const AddItems({super.key});

  @override
  State<AddItems> createState() => _AddItemsState();
}

class _AddItemsState extends State<AddItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add new items"),
        ),
        body: Column(
          children: [
            const Text("Adding new items page"),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UploadImage(),
                  ),
                );
              },
              child: const Text('Add image'),
            )
          ],
        ));
  }
}
