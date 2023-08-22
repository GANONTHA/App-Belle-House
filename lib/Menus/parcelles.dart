import 'package:bellehouse/services/storage/property_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Parcelle extends StatefulWidget {
  const Parcelle({super.key});

  @override
  State<Parcelle> createState() => _ParcelleState();
}

class _ParcelleState extends State<Parcelle> {
  // final List parcellesPourToi = [
  //   //[postimage, type, size, location, price, view]
  //   ['lib/assets/land_one.jpg', 'ETAGE', 250.0, 'Francophonie', 200000.0, 09],
  //   ['lib/assets/land_two.jpg', 'VILLA', 150.0, 'Plateau', 10000.0, 03],
  //   ['lib/assets/land_three.jpg', 'Parcelle', 200.0, 'Danzama', 400000.0, 03],
  // ];
  final PropertyService _propertyService = PropertyService();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_buildLandsList()],
    );
  }

  Widget _buildLandsList() {
    return StreamBuilder(
        stream: _propertyService.getLand(),
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
                    .map((document) => _buildLandItems(document))
                    .toList(),
              ),
            );
          }
          return Container();
        });
  }

  Widget _buildLandItems(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 200,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(data['landImage'].toString()),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //Type and like button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          data['type'].toString(),
                          style: const TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF6C63FF)),
                        ),
                        const Icon(
                          Icons.favorite,
                          color: Color(0xFF6C63FF),
                        ),
                      ],
                    ),
                    //bedroom

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.area_chart,
                          color: Color(0xFF6C63FF),
                          size: 24.0,
                        ),
                        Text(
                          '${data['size']} m2',
                          style: const TextStyle(color: Color(0xFF6C63FF)),
                        ),
                      ],
                    ),
                    //Location
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 24.0,
                          color: Color(0xFF6C63FF),
                        ),
                        Text(
                          data['location'].toString(),
                          style: const TextStyle(
                              color: Color(0xFF6C63FF),
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0),
                        )
                      ],
                    ),
                    //Price and views

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //price
                        Row(
                          children: [
                            const Icon(
                              Icons.money,
                              color: Color(0xFF6C63FF),
                              size: 24.0,
                            ),
                            Text(
                              data['price'].toString(),
                              style: const TextStyle(
                                  color: Color(0xFF6C63FF),
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        //VIEWS

                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(
                              Icons.visibility,
                              color: Color(0xFF6C63FF),
                              size: 24.0,
                            ),
                            Text(
                              "${data['view']} vues",
                              style: const TextStyle(
                                color: Color(0xFF6C63FF),
                                fontSize: 12.0,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
