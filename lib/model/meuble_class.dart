import 'package:cloud_firestore/cloud_firestore.dart';

// class FurnituresList {
//   final List<Furnitures> furnituresList;
//   FurnituresList({required this.furnituresList});
//   factory FurnituresList.fromSnapshot(QueryDocumentSnapshot snapshot) {
//     return FurnituresList(
//       furnituresList: [
//         // ignore: unnecessary_cast
//         ...snapshot['items'] as List,
//       ],
//     );
//   }
// }

class Furnitures {
  final String description;
  final String meubleImage;
  final String meubleName;
  final String sellerName;
  final String location;
  final double price;
  final Timestamp timeStamp;
  final dynamic meubleId;
  Furnitures({
    required this.description,
    required this.timeStamp,
    required this.meubleImage,
    required this.meubleName,
    required this.sellerName,
    required this.location,
    required this.price,
    this.meubleId,
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
      'meubleId': meubleId,
      'description': description,
    };
  }
}
