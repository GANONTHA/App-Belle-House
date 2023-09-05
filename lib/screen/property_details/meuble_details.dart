import 'dart:io';

import 'package:bellehouse/controller/functions/convert_time_to_ago.dart';
import 'package:bellehouse/model/meuble_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class MeubleDetails extends StatelessWidget {
  final Furnitures meuble;
  const MeubleDetails({super.key, required this.meuble});

  @override
  Widget build(BuildContext context) {
    Timestamp date = meuble.timeStamp;

    final String preConverted = "$date";
    final int seconds = int.parse(preConverted.substring(18, 28));
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
    String time = convertToAgo(dateTime);
    // print(meuble);

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
                  'https://drive.google.com/file/d/1sGqerIGjakZzALmPmSG7yPhXP5-rjM6W/view?usp=drive_link';
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
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          //image
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(9.0)),
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(meuble.meubleImage),
                  )),
            ),
          ),

          //name
          Text(
            meuble.meubleName,
            style: const TextStyle(
                fontWeight: FontWeight.bold, letterSpacing: 1.2),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Taille: 2.3 m"),
                Text("Publie il y a $time")
              ],
            ),
          ),
          const SizedBox(height: 20),
          //size
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Description',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(meuble.description),
            ],
          ),
          const SizedBox(height: 25),
          //description
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Plus d'images",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(meuble.meubleImage),
                          )),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(meuble.meubleImage),
                          )),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(meuble.meubleImage),
                          )),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(meuble.meubleImage),
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Prix",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${meuble.price.toString()} FCFA",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C63FF)),
                  onPressed: () {},
                  child: const Text(
                    "Acheter",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
