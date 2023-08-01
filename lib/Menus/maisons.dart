import 'package:bellehouse/utilities/menu_sources/maisons_source.dart';
import 'package:flutter/material.dart';

class Maison extends StatefulWidget {
  const Maison({super.key});

  @override
  State<Maison> createState() => _MaisonState();
}

class _MaisonState extends State<Maison> {
  final List housesPourToi = [
    //[postimage, type, size, location, price, view]
    ['lib/assets/post_one.jpg', 'ETAGE', 3, 'Francophonie', 200000.0, 9],
    ['lib/assets/post_two.jpg', 'VILLA', 5, 'Plateau', 100000.0, 3],
    ['lib/assets/post_three.jpg', 'Parcelle', 6, 'Danzama', 400000.0, 3],
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
            child: Houses(
                postImage: housesPourToi[index][0],
                type: housesPourToi[index][1],
                bedroom: housesPourToi[index][2],
                location: housesPourToi[index][3],
                price: housesPourToi[index][4],
                view: housesPourToi[index][5]),
          );
        });
  }
}
