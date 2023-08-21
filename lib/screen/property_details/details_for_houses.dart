import 'package:bellehouse/services/storage/property_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class HousesDetails extends StatefulWidget {
  const HousesDetails({super.key});

  @override
  State<HousesDetails> createState() => _HousesDetailsState();
}

class _HousesDetailsState extends State<HousesDetails> {
  final PropertyService _propertyService = PropertyService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
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
          IconButton(
            onPressed: () {
              setState(() {
                if (isLiked == likes[0]) {
                  isLiked = likes[1];
                } else {
                  isLiked = likes[0];
                }
              });
            },
            icon: Icon(
              Icons.favorite,
              color: isLiked ? const Color(0xFF6C63FF) : Colors.grey,
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: Column(
        children: [
          //property image
          Expanded(
            flex: 2,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 5),
                  child: SizedBox(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: _buildPropertyImagesList(),
                  ),
                ),
              ],
            ),
          ),
//property details
          Expanded(
            flex: 3,
            child: _buildPropertyDetails(),
          )
        ],
      ),
    );
  }

//Post's image
  Widget _buildPropertyImagesList() {
    return StreamBuilder<QuerySnapshot>(
        stream: _propertyService.getHouse(_firebaseAuth.currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error.toString()}");
          }
          if (snapshot.hasData) {
            final List<DocumentSnapshot> documents = snapshot.data!.docs;

            return ListView(
                scrollDirection: Axis.vertical,
                children: documents
                    .map((document) => _grabPropertyImage(document))
                    .toList());
          }
          return Container(
            height: 100,
          );
        });
  }

  Widget _grabPropertyImage(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    return Image.asset(data['postImage']);
  }

  //propety's details

  Widget _buildPropertyDetails() {
    return StreamBuilder<QuerySnapshot>(
        stream: _propertyService.getHouse(_firebaseAuth.currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error.toString()}");
          }
          if (snapshot.hasData) {
            final List<DocumentSnapshot> documents = snapshot.data!.docs;

            return ListView(
                scrollDirection: Axis.vertical,
                children: documents
                    .map((document) => _grabPropertyDetails(document))
                    .toList());
          }
          return Container(
            height: 100,
          );
        });
  }

  Widget _grabPropertyDetails(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    return Column(
      children: [
        //price and contract type
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //price & area
              Column(
                children: [
                  Text(data['price'].toString()),
                  Text('Quartier: ${data['area'].toString()}')
                ],
              ),
              //contractype
              Container(
                decoration: const BoxDecoration(
                    color: Color(0xA11640D8),
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    data['contractType'],
                    style: const TextStyle(
                        color: Colors.white, letterSpacing: 1.2),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(
          thickness: 0.3,
          color: Colors.black,
        ),
        const SizedBox(
          height: 10.0,
        ),
        //rooms details
        const Text(
          'Propriete du logement',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //first column
            Column(
              children: [
                Text("Chambres: ${data['bedrooms'].toString()}"),
                Text("Douches : ${data["bathroom"].toString()} "),
                Text("Salle a manger: ${data['city'].toString()}"),
                Text("Annexe: ${data['area'].toString()}"),
              ],
            ),
            //second column
            Column(
              children: [
                Text("Superficie: ${data['size'].toString()}."),
                Text("Cuisine: ${data["rating"].toString()} "),
                Text("Meuble: ${data['city'].toString()}"),
                Text("Etat: ${data['area'].toString()}"),
              ],
            ),
          ],
        ),
        const Divider(
          thickness: 0.3,
          color: Colors.black,
        ),
        const SizedBox(
          height: 10.0,
        ),
        //agent details
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const Text('Publiee le: '),
                Text(data['city'].toString())
              ],
            ),
            Column(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(data['agentPhoto']),
                ),
                Text(
                  "Agence ${data['agentName']}",
                  style: const TextStyle(fontSize: 8.0),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
