import 'package:cloud_firestore/cloud_firestore.dart';

class Furnitures {
  final String meubleImage;
  final String meubleName;
  final String sellerName;
  final String location;
  final double price;
  final Timestamp timeStamp;
  Furnitures({
    required this.timeStamp,
    required this.meubleImage,
    required this.meubleName,
    required this.sellerName,
    required this.location,
    required this.price,
  });
  //convert the meuble to map

  Map<String, dynamic> toMap() {
    return {
      'meubleImage': meubleImage,
      'meubleName': meubleName,
      'sellerName': sellerName,
      'location': location,
      'price': price,
      'timeStamp': timeStamp,
    };
  }
}
