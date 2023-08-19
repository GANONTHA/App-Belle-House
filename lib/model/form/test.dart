import 'package:bellehouse/services/property_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final PropertyService _propertyService = PropertyService();

  //exemple
  final List houses = [
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
    'agent@gmail.com'
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
    );
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
                  onPressed: postHouse, child: const Text('click me'))),
          Expanded(flex: 2, child: _buildPostList()),
        ],
      ),
    );
  }

  Widget _buildPostList() {
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
    print(data);
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
