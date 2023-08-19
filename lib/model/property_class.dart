import 'package:cloud_firestore/cloud_firestore.dart';

class Property {
  final String postImage;
  final String city;
  final double rating;
  final String type;
  final String contractType;
  final double price;
  final String area;
  final int bedrooms;
  final int bathrooms;
  final double size;
  final String agentName;
  final String agentPhoto;
  final String agentEmail;
  final Timestamp timeStamp;
  Property({
    required this.postImage,
    required this.city,
    required this.rating,
    required this.type,
    required this.contractType,
    required this.price,
    required this.area,
    required this.bedrooms,
    required this.bathrooms,
    required this.size,
    required this.agentName,
    required this.agentPhoto,
    required this.timeStamp,
    required this.agentEmail,
  });
  //convert property to map

  Map<String, dynamic> toMap() {
    return {
      'postImage': postImage,
      'city': city,
      'rating': rating,
      'type': type,
      'contractType': contractType,
      'price': price,
      'area': area,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'size': size,
      'agentName': agentName,
      'agentPhoto': agentPhoto,
      'timeStamp': timeStamp,
      'agentEmail': agentEmail,
    };
  }
}
