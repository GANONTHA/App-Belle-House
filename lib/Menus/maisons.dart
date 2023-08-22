import 'package:bellehouse/services/storage/property_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Maison extends StatefulWidget {
  const Maison({super.key});

  @override
  State<Maison> createState() => _MaisonState();
}

class _MaisonState extends State<Maison> {
  //grab the instance of the property
  final PropertyService _propertyService = PropertyService();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 250, child: _buildHouseList()),
      ],
    );
  }

  Widget _buildHouseList() {
    return StreamBuilder(
        stream: _propertyService.getHouse(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData || !snapshot.data!.docs.isNotEmpty) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error.toString()}");
          }
          if (snapshot.hasData) {
            final List<DocumentSnapshot> documents = snapshot.data!.docs;

            return ListView(
              scrollDirection: Axis.vertical,
              children: documents
                  .map((document) => _grabHouseItem(document))
                  .toList(),
            );
          }
          return Container();
        });
  }

  Widget _grabHouseItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    return Container(
      color: Colors.grey.shade300,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(data['postImage'].toString()),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        Icons.bed,
                        color: Color(0xFF6C63FF),
                        size: 24.0,
                      ),
                      Text(
                        '${data['bedrooms']} Chambres',
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
                        data['city'].toString(),
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
                                color: Color(0xFF6C63FF), fontSize: 12.0),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
