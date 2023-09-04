import 'package:flutter/material.dart';

class Near extends StatelessWidget {
  final String postImage;
  final String type;
  final int bedroom;
  final int bathroom;
  final double size;
  final double prix;
  final String location;
  const Near({
    super.key,
    required this.postImage,
    required this.type,
    required this.bedroom,
    required this.bathroom,
    required this.size,
    required this.prix,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(postImage),
                  fit: BoxFit.fill,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //TYPE
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        type,
                        style: const TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),

                //ICONS

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Bedroom
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.bed,
                            size: 24.0,
                          ),
                          Text(
                            bedroom.toString(),
                            style: const TextStyle(fontSize: 12.0),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),

                      //Bathroom
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.shower,
                            size: 24.0,
                          ),
                          Text(
                            bathroom.toString(),
                            style: const TextStyle(fontSize: 12.0),
                          ),
                        ],
                      ),

                      //Size

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.area_chart,
                            size: 24.0,
                          ),
                          Text(
                            size.toString(),
                            style: const TextStyle(fontSize: 12.0),
                          )
                        ],
                      ),
                    ],
                  ),
                ),

                //PRICE and LOCATIOn

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //PRICE
                      Text(
                        "$prix /MOIS",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10.0,
                        ),
                      ),
                      //LOCATION
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 17.0,
                          ),
                          Text(
                            location,
                            style: const TextStyle(fontSize: 10.0),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
