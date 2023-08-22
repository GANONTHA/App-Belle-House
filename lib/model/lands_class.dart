import 'package:cloud_firestore/cloud_firestore.dart';

class Lands {
  final String landImage;
  final String location;
  final double price;
  final double size;
  final String type;
  final int views;
  final Timestamp timeStamp;
  Lands(
      {required this.timeStamp,
      required this.landImage,
      required this.location,
      required this.price,
      required this.size,
      required this.views,
      required this.type});
  //convert the data to map
  Map<String, dynamic> toMap() {
    return {
      'landImage': landImage,
      'location': location,
      'price': price,
      'size': size,
      'views': views,
      'timeStamp': timeStamp,
      'type': type,
    };
  }
}
