import 'package:bellehouse/services/storage/property_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Meuble extends StatefulWidget {
  const Meuble({super.key});

  @override
  State<Meuble> createState() => _MeubleState();
}

class _MeubleState extends State<Meuble> {
  // final List meubleForYou = [
  //   //[propretyImage, name, sellerName, location, price],
  //   ['lib/assets/table.jpg', 'Table', 'Boutique Bazar', 'Niamey', 20000.0],
  //   ['lib/assets/sofa.jpg', 'Sofa', 'Belle House', 'Niamey', 30000.0],
  //   ['lib/assets/bed.jpg', 'Lit deux place', 'Belle House', 'Zinder', 10000.0],
  // ];
  final PropertyService _propertyService = PropertyService();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_buildFurnituresList()],
    );
  }

  Widget _buildFurnituresList() {
    return StreamBuilder(
        stream: _propertyService.getMeuble(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData || !snapshot.data!.docs.isNotEmpty) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error.toString()}");
          }
          if (snapshot.hasData) {
            final List<DocumentSnapshot> documents = snapshot.data!.docs;
            return Container(
              height: 600,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: documents
                    .map((document) => _buildFurnituresItem(document))
                    .toList(),
              ),
            );
          }
          return Container();
        });
  }

  Widget _buildFurnituresItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 300,
        child: Column(
          children: [
            //Image
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(data['meubleImage'].toString()),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(8.0))),
              ),
            ),
            //Description
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Meuble: ${data['meubleName']}",
                        style: const TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Prix: ${data['price']} FCFA',
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Vendeur: ${data['sellerName']}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12.0),
                      ),
                      Text(
                        "Localisation: ${data['location']}",
                        style: const TextStyle(
                            fontSize: 12.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
