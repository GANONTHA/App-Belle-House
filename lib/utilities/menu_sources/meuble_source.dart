import 'package:flutter/material.dart';

class MeubleSource extends StatelessWidget {
  final String propertyImage;
  final String name;
  final String sellerName;
  final String location;
  final double price;
  const MeubleSource({
    super.key,
    required this.propertyImage,
    required this.name,
    required this.sellerName,
    required this.location,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Image
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(propertyImage),
                  fit: BoxFit.fill,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(8.0))),
          ),
        ),
        //Description
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Meuble: $name",
                    style: const TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Prix: $price FCFA',
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Vendeur: $sellerName",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 12.0),
                  ),
                  Text(
                    location,
                    style: const TextStyle(
                        fontSize: 12.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
