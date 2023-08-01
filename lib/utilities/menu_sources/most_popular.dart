import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class Popular extends StatelessWidget {
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
  DateTime now = DateTime.now();

  Popular({
    super.key,
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
  });

  @override
  Widget build(BuildContext context) {
    String time = DateFormat('dd-MM-yyyy').format(now);
    return Column(
      children: <Widget>[
        Stack(children: <Widget>[
          //display the image of the post
          Container(
            height: 200.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(postImage), fit: BoxFit.fill)),
          ),
          //display the city and the rate
          Padding(
            padding: const EdgeInsets.only(left: 3.0, right: 3.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Text(
                    city,
                    style: const TextStyle(
                      color: Color(0xA11640D8),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.white),
                    Text(
                      rating.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ]),

        //display the price and the type of contact(A Louer ou en Vente)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 3.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Prix: ${price.toString()}FCFA/Mois",
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Container(
                decoration: const BoxDecoration(
                    color: Color(0xA11640D8),
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    contractType,
                    style: const TextStyle(
                        color: Colors.white, letterSpacing: 1.2),
                  ),
                ),
              ),
            ],
          ),
        ),

        //diaplay the type of property and the area

        Padding(
          padding: const EdgeInsets.only(left: 3.0, right: 3.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xA11640D8),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    type,
                    style: const TextStyle(
                        color: Colors.white, letterSpacing: 1.2),
                  ),
                ),
              ),
              Text(
                "Quartier: $area",
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Divider(
            color: Colors.black,
          ),
        ),

        //Displaying icons
        Padding(
          padding: const EdgeInsets.only(left: 3.0, right: 3.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //BED
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.bed,
                    size: 27.0,
                    color: Color(0xFF6C63FF),
                  ),
                  const SizedBox(
                    width: 13.0,
                  ),
                  Text(
                    bedrooms.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),

              //BATH

              Row(
                children: [
                  const Icon(
                    Icons.shower,
                    size: 27.0,
                    color: Color(0xFF6C63FF),
                  ),
                  const SizedBox(
                    width: 13.0,
                  ),
                  Text(
                    bathrooms.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),

              //SIZE

              Row(
                children: [
                  const Icon(
                    Icons.area_chart,
                    size: 27.0,
                    color: Color(0xFF6C63FF),
                  ),
                  const SizedBox(
                    width: 13.0,
                  ),
                  Text(
                    size.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Divider(
            color: Colors.black,
          ),
        ),

        //Diaplay the time of posting and agent profile

        Padding(
          padding: const EdgeInsets.only(left: 3.0, right: 2.0),
          child: SizedBox(
            height: 32,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pubie le $time',
                  style: const TextStyle(fontSize: 10),
                ),
                Column(
                  children: [
                    Container(
                      width: 20.0,
                      height: 20.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(agentPhoto),
                            fit: BoxFit.fill,
                          )),
                    ),
                    Text(
                      agentName,
                      style: const TextStyle(fontSize: 10),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
