import 'package:flutter/material.dart';

import '../utilities/menu_sources/parcelle_source.dart';

class Parcelle extends StatefulWidget {
  const Parcelle({super.key});

  @override
  State<Parcelle> createState() => _ParcelleState();
}

class _ParcelleState extends State<Parcelle> {
  final List parcellesPourToi = [
    //[postimage, type, size, location, price, view]
    ['lib/assets/land_one.jpg', 'ETAGE', 250.0, 'Francophonie', 200000.0, 09],
    ['lib/assets/land_two.jpg', 'VILLA', 150.0, 'Plateau', 10000.0, 03],
    ['lib/assets/land_three.jpg', 'Parcelle', 200.0, 'Danzama', 400000.0, 03],
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.grey[200],
            height: 180,
            padding:
                const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            child: ParcelleSource(
                postImage: parcellesPourToi[index][0],
                type: parcellesPourToi[index][1],
                size: parcellesPourToi[index][2],
                location: parcellesPourToi[index][3],
                price: parcellesPourToi[index][4],
                view: parcellesPourToi[index][5]),
          );
        });
  }
}
