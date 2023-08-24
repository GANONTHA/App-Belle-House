import 'package:bellehouse/services/storage/property_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final PropertyService _propertyService = PropertyService();

  //exemple
  final List houses = [
    'lib/assets/post_three.jpg',
    'Niamey',
    4.2,
    'VILLA',
    'A LOUER',
    100000.0,
    'FRANCOPHONIE',
    06,
    04,
    200.0,
    'Belle House',
    'lib/assets/profile.jpg',
    'agent@gmail.com',
    03,
    'neuf'
  ];
  final List meubles = [
    //[propretyImage, name, sellerName, location, price],
    'lib/assets/sofa.jpg', 'Sofa', 'Baklini', 'Niamey', 50000.0,
    'La table en bois de taille normale, ideal pour les salles de reunion ou les salles de classe'
    // ['lib/assets/sofa.jpg', 'Sofa', 'Belle House', 'Niamey', 30000.0],
    // ['lib/assets/bed.jpg', 'Lit deux place', 'Belle House', 'Zinder', 10000.0],
  ];
  final List parcelles = [
    //[postimage, type, size, location, price, view]
    'lib/assets/land_one.jpg', 'ETAGE', 250.0, 'Francophonie', 200000.0, 09,
    // ['lib/assets/land_two.jpg', 'VILLA', 150.0, 'Plateau', 10000.0, 03],
    // ['lib/assets/land_three.jpg', 'Parcelle', 200.0, 'Danzama', 400000.0, 03],
  ];
  //upoad house
  void postHouse() async {
    await _propertyService.uploadHouse(
      houses[0],
      houses[1],
      houses[2],
      houses[3],
      houses[4],
      houses[5],
      houses[6],
      houses[7],
      houses[8],
      houses[9],
      houses[10],
      houses[11],
      houses[12],
      true,
      true,
      true,
      true,
      'neuf',
      houses[13],
    );
  }

  void postMeuble() async {
    await _propertyService.uploadMeuble(
      meubles[0],
      meubles[1],
      meubles[4],
      meubles[2],
      meubles[3],
      meubles[5],
    );
  }

  void postParcelle() async {
    await _propertyService.uploadLand(parcelles[0], parcelles[3], parcelles[2],
        parcelles[5], parcelles[4], parcelles[1]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex: 1,
              child: TextButton(
                  onPressed: postMeuble, child: const Text('click me'))),
          Expanded(flex: 2, child: _buildPostList()),
        ],
      ),
    );
  }

  Widget _buildPostList() {
    return StreamBuilder<QuerySnapshot>(
        stream: _propertyService.getHouse(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error.toString()}");
          }
          if (snapshot.hasData) {
            final List<DocumentSnapshot> documents = snapshot.data!.docs;

            return ListView(
                scrollDirection: Axis.vertical,
                children: documents
                    .map((document) => _buildPostItem(document))
                    .toList());
          }
          return Container(
            height: 100,
          );
        });
  }

  Widget _buildPostItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    return Container(
      height: 200,
      child: Column(
        children: [
          Image.asset(
            data['postImage'],
            height: 100,
            width: 100,
          ),
          Text(data['city'])
        ],
      ),
    );
  }
}
