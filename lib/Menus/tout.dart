import 'package:bellehouse/utilities/menu_sources/most_popular.dart';
import 'package:bellehouse/utilities/menu_sources/near_you.dart';
import 'package:flutter/material.dart';

class Tout extends StatefulWidget {
  const Tout({super.key});

  @override
  State<Tout> createState() => _ToutState();
}

class _ToutState extends State<Tout> {
  final List populaire = [
    [
      'lib/assets/post_one.jpg',
      'Niamey',
      2.2,
      'VILLA',
      'A LOUER',
      50000.0,
      'KOIRA KANO',
      04,
      02,
      200.0,
      'Belle House',
      'lib/assets/profile.jpg',
    ],
    [
      'lib/assets/post_two.jpg',
      'Maradi',
      4.1,
      'ETAGE',
      'EN VENTE',
      5000000.0,
      'Aeroport',
      10,
      05,
      300.0,
      'Belle House',
      'lib/assets/profile.jpg'
    ],
    [
      'lib/assets/post_three.jpg',
      'Niamey',
      3.1,
      'VILLA',
      'A LOUER',
      100000.0,
      'FRANCOPHONIE',
      05,
      02,
      100.0,
      'Belle House',
      'lib/assets/profile.jpg'
    ],
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        //posts: les plus populaires
        const Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Les plus Populaires',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
        ),
        //POSTS

        Expanded(
          flex: 2,
          child: ListView.builder(
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Container(
                    width: 350,
                    color: const Color(0xFFD9D9D9),
                    child: Popular(
                      postImage: populaire[index][0],
                      city: populaire[index][1],
                      rating: populaire[index][02],
                      type: populaire[index][3],
                      contractType: populaire[index][4],
                      price: populaire[index][5],
                      area: populaire[index][6],
                      bedrooms: populaire[index][7],
                      bathrooms: populaire[index][8],
                      size: populaire[index][9],
                      agentName: populaire[index][10],
                      agentPhoto: populaire[index][11],
                    ),
                  ),
                );
              }),
        ),
        //posts les plus proches
        const Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Les Plus Proches',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
        ),
        //POSTS

        Expanded(
          flex: 1,
          child: ListView.builder(
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 6.0),
                  child: Container(
                      // padding: EdgeInsets.only(right: 19.0),

                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8.0)),
                        color: Colors.grey[200],
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: const Near(
                          postImage: 'lib/assets/post_three.jpg',
                          type: 'VILLA',
                          bedroom: 2,
                          bathroom: 2,
                          size: 200.0,
                          prix: 60000,
                          location: 'PLATEAU')),
                );
              }),
        ),
      ]),
    );
  }
}
