import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}
