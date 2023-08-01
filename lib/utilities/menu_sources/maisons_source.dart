import 'package:flutter/material.dart';

class Houses extends StatelessWidget {
  final String postImage;
  final String type;
  final int bedroom;
  final String location;
  final double price;
  final int view;
  const Houses(
      {super.key,
      required this.postImage,
      required this.type,
      required this.bedroom,
      required this.location,
      required this.price,
      required this.view});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(postImage),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //Type and like button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        type,
                        style: const TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF6C63FF)),
                      ),
                      const Icon(
                        Icons.favorite,
                        color: Color(0xFF6C63FF),
                      ),
                    ],
                  ),
                  //bedroom

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.bed,
                        color: Color(0xFF6C63FF),
                        size: 24.0,
                      ),
                      Text(
                        '$bedroom Chambres',
                        style: const TextStyle(color: Color(0xFF6C63FF)),
                      ),
                    ],
                  ),
                  //Location
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 24.0,
                        color: Color(0xFF6C63FF),
                      ),
                      Text(
                        location,
                        style: const TextStyle(
                            color: Color(0xFF6C63FF),
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0),
                      )
                    ],
                  ),
                  //Price and views

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //price
                      Row(
                        children: [
                          const Icon(
                            Icons.money,
                            color: Color(0xFF6C63FF),
                            size: 24.0,
                          ),
                          Text(
                            price.toString(),
                            style: const TextStyle(
                                color: Color(0xFF6C63FF),
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      //VIEWS

                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.visibility,
                            color: Color(0xFF6C63FF),
                            size: 24.0,
                          ),
                          Text(
                            "$view vues",
                            style: const TextStyle(
                                color: Color(0xFF6C63FF), fontSize: 12.0),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
