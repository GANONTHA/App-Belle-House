import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

void showSnackBar(BuildContext context, content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

//picking image
Future<File?> pickImage(BuildContext context) async {
  File? image;
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    showSnackBar(context, e.toString());
  }
  return image;
}

String displayDateTime(DateTime date) {
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formattedDate = formatter.format(date);
  final String formattedNow = formatter.format(now);
  final String formattedYesterday =
      formatter.format(now.subtract(Duration(days: 1)));
  if (formattedDate == formattedNow) {
    return 'today at ${DateFormat.Hm().format(date)}';
  } else if (formattedDate == formattedYesterday) {
    return 'yesterday';
  } else {
    return formattedDate;
  }
}
