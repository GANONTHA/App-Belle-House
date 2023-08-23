import 'package:bellehouse/model/houses_class.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

// ignore: must_be_immutable
class HousesDetails extends StatelessWidget {
  final Property property;
  HousesDetails({required this.property, super.key});

  //grab instance of the property
  List<bool> likes = [false, true];

  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
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
            "Détails",
            style: TextStyle(
              color: Color(0xFF6C63FF),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.share,
                color: Color(0xFF6C63FF),
              ),
            ),
          ],
          centerTitle: true,
        ),
        body: Text(property.city));
  }
}
