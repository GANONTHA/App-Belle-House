import 'package:bellehouse/utilities/menu_sources/meuble_source.dart';
import 'package:flutter/material.dart';

class Meuble extends StatefulWidget {
  const Meuble({super.key});

  @override
  State<Meuble> createState() => _MeubleState();
}

class _MeubleState extends State<Meuble> {
  final List meubleForYou = [
    //[propretyImage, name, sellerName, location, price],
    ['lib/assets/table.jpg', 'Table', 'Boutique Bazar', 'Niamey', 20000.0],
    ['lib/assets/sofa.jpg', 'Sofa', 'Belle House', 'Niamey', 30000.0],
    ['lib/assets/bed.jpg', 'Lit deux place', 'Belle House', 'Zinder', 10000.0],
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.grey[200],
            height: 300,
            padding:
                const EdgeInsets.only(left: 40.0, right: 40.0, bottom: 10.0),
            child: MeubleSource(
              propertyImage: meubleForYou[index][0],
              name: meubleForYou[index][1],
              sellerName: meubleForYou[index][2],
              location: meubleForYou[index][3],
              price: meubleForYou[index][4],
            ),
          );
        });
  }
}
