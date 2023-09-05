import 'dart:io';

import 'package:bellehouse/controller/functions/convert_time_to_ago.dart';
import 'package:bellehouse/model/houses_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class HousesDetails extends StatelessWidget {
  final Property property;
  HousesDetails({required this.property, super.key});

  //grab instance of the property
  List<bool> likes = [false, true];

  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    Timestamp date = property.timeStamp;

    final String preConverted = "$date";
    final int seconds = int.parse(preConverted.substring(18, 28));
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(seconds * 1000);

    String time = convertToAgo(dateTime);
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
              onPressed: () async {
                const imageUrl =
                    'https://drive.google.com/file/d/1jmYDs5JIswAt7E14ekmyW3d6Hr_Hbe6c/view?usp=drive_link';
                final uri = Uri.parse(imageUrl);
                final response = await http.get(uri);
                final bytes = response.bodyBytes;
                final temp = await getTemporaryDirectory();
                final path = '${temp.path}/image.jpg';
                File(path).writeAsBytesSync(bytes);
                // ignore: deprecated_member_use
                await Share.shareFiles([path],
                    text: 'image partge avec succes');
              },
              icon: const Icon(
                Icons.share,
                color: Color(0xFF6C63FF),
              ),
            ),
          ],
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 3.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .4,
                  width: 380,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(3.0)),
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(property.postImage),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${property.price}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    Container(
                      height: 24.0,
                      width: 65,
                      decoration: const BoxDecoration(
                          color: Color(0x9C6C63FF),
                          borderRadius: BorderRadius.all(Radius.circular(3.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          property.contractType,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Quartier: ${property.area}"),
                  ],
                ),
                const Divider(
                  thickness: 0.3,
                  height: 16.0,
                  color: Colors.black,
                ),
                const Text(
                  'Proprietes du logement',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //first column
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Chambres: ${property.bedrooms}",
                            style:
                                const TextStyle(fontWeight: FontWeight.w700)),
                        const SizedBox(height: 10.0),
                        Text("Douches: ${property.bathrooms}",
                            style:
                                const TextStyle(fontWeight: FontWeight.w700)),
                        const SizedBox(height: 10.0),
                        Text("Salle a manger: ${property.diningroom}",
                            style:
                                const TextStyle(fontWeight: FontWeight.w700)),
                        const SizedBox(height: 10.0),
                        Text("Annexe: ${property.annexe}",
                            style:
                                const TextStyle(fontWeight: FontWeight.w700)),
                      ],
                    ),
                    //second column
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Superficie: ${property.size}",
                            style:
                                const TextStyle(fontWeight: FontWeight.w700)),
                        const SizedBox(height: 10.0),
                        Text("Cuisine: ${property.cuisine}",
                            style:
                                const TextStyle(fontWeight: FontWeight.w700)),
                        const SizedBox(height: 10.0),
                        Text("Meuble: ${property.meublee}",
                            style:
                                const TextStyle(fontWeight: FontWeight.w700)),
                        const SizedBox(height: 10.0),
                        Text("Etat: ${property.etatDeMaison}",
                            style:
                                const TextStyle(fontWeight: FontWeight.w700)),
                      ],
                    )
                  ],
                ),
                const Divider(
                  thickness: .3,
                  height: 16.0,
                  color: Colors.black,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //time
                    Column(
                      children: [const Text("Publiee il y a:"), Text(time)],
                    ),
                    //agent's infos
                    Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * .1,
                          width: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(property.agentPhoto),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Text(
                          property.agentName,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0x9C6C63FF)),
                      onPressed: () {},
                      child: const Row(
                        children: [
                          Text('Message'),
                          SizedBox(width: 10.0),
                          Icon(Icons.message)
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0x9C6C63FF)),
                      onPressed: () {},
                      child: const Row(
                        children: [
                          Text('Appellez'),
                          SizedBox(width: 10.0),
                          Icon(Icons.call)
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
