import 'package:bellehouse/utilities/navigation_bar_screen_source/favorite_source.dart';
import 'package:flutter/material.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  final List housesPourToi = [
    //[postimage, type, size, location, price, view]
    ['lib/assets/post_one.jpg', 'ETAGE', 3, 'Francophonie', 200000.0, 9],
    ['lib/assets/post_two.jpg', 'VILLA', 5, 'Plateau', 100000.0, 3],
    ['lib/assets/post_three.jpg', 'Parcelle', 6, 'Danzama', 400000.0, 3],
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Favories",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.3,
            fontSize: 36.0,
          ),
        ),
        backgroundColor: Colors.white,
        toolbarHeight: 90,
        centerTitle: true,
      ),
      body: Center(
        child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                color: Colors.grey[200],
                height: 180,
                padding:
                    const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                child: FavoritesSource(
                    postImage: housesPourToi[index][0],
                    type: housesPourToi[index][1],
                    bedroom: housesPourToi[index][2],
                    location: housesPourToi[index][3],
                    price: housesPourToi[index][4],
                    view: housesPourToi[index][5]),
              );
            }),
      ),
    );
  }
}
