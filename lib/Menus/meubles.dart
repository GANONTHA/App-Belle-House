import 'package:bellehouse/model/meuble_class.dart';
import 'package:bellehouse/screen/property_details/meuble_details.dart';
import 'package:bellehouse/services/storage/property_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
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
  final List ids = [];
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
                    .map(
                      (document) => buildFurnituresItem(document),
                    )
                    .toList(),
              ),
            );
          }
          return Container();
        });
  }

  Widget buildFurnituresItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    String meubleImage = data['meubleImage'];
    String meubleName = data['meubleName'];
    double price = data['price'];
    String sellerName = data['sellerName'];
    String descripiton = data['description'];
    Timestamp timestamp = data['timeStamp'];
    // var meubleId = data['meubleId'];

    String location = data['location'];

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MeubleDetails(
              meuble: Furnitures(
                timeStamp: timestamp,
                meubleImage: meubleImage,
                meubleName: meubleName,
                sellerName: sellerName,
                location: location,
                description: descripiton,
                price: price,
              ),
            ),
          ),
        );
      },
      child: Padding(
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
                      image: AssetImage(meubleImage.toString()),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  ),
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
                          "Meuble: $meubleName",
                          style: const TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Prix: $price FCFA',
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
                          "Vendeur: $sellerName",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12.0),
                        ),
                        Text(
                          "Localisation: $location",
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
      ),
    );
  }

  //Widget get buildFurnituresItem => _buildFurnituresItem( DocumentSnapshot document),
}
