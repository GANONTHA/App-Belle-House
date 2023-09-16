import 'dart:io';

import 'package:bellehouse/controller/functions/convert_time_to_ago.dart';
import 'package:bellehouse/model/lands_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';

// ignore: must_be_immutable
class LandDetails extends StatelessWidget {
  Lands land;
  LandDetails({required this.land, super.key});

  @override
  Widget build(BuildContext context) {
    Timestamp date = land.timeStamp;

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
        actions: [
          IconButton(
            onPressed: () async {
              const imageUrl =
                  'https://drive.google.com/file/d/1m6mYY5sAbU8jagyb_qBLZYW-6yG7ajNI/view?usp=drive_link';
              final uri = Uri.parse(imageUrl);
              final response = await http.get(uri);
              final bytes = response.bodyBytes;
              final temp = await getTemporaryDirectory();
              final path = '${temp.path}/image.jpg';
              File(path).writeAsBytesSync(bytes);
              // ignore: deprecated_member_use
              await Share.shareFiles([path], text: 'image partge avec succes');
            },
            icon: const Icon(
              Icons.share,
              color: Color(0xFF6C63FF),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 3.0, right: 3.0),
        child: ListView(
          children: [
            //image
            Container(
              height: 300,
              width: 400,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(land.landImage),
                  )),
            ),
            const SizedBox(height: 20),
            //descriptions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  land.location,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  "Superficie: ${land.size}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Prix: ${land.price}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Publiee il y a: $time",
                  style: const TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                Column(
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(land.agentImage),
                        ),
                      ),
                    ),
                    Text("Agence ${land.agentName}")
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            //images
            const Text(
              "Plus d'images",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0, top: 8.0),
                    child: Container(
                      height: 100,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5.0)),
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                              image: AssetImage(land.landImage))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0, top: 8.0),
                    child: Container(
                      height: 100,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          image: AssetImage(land.landImage),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0, top: 8.0),
                    child: Container(
                      height: 100,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          image: AssetImage(land.landImage),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
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
    );
  }
}
